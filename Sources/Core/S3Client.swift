import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Sends signed requests to the S3-compatible API of Simple Object Storage (SOS) in one zone.
final class S3Client: Sendable {
    let endpoint: URL
    let userAgent: String
    private let signer: S3Signer
    private let session: URLSession

    init(configuration: Exoscale.Configuration, sessionConfiguration: URLSessionConfiguration) throws {
        guard let endpoint = configuration.zone.sosEndpoint else {
            throw Exoscale.ClientError.invalidZone(configuration.zone.rawValue)
        }
        self.endpoint = endpoint
        userAgent = configuration.userAgent
        signer = S3Signer(
            accessKey: configuration.apiKey,
            secretKey: configuration.apiSecret,
            region: configuration.zone.rawValue
        )
        session = URLSession(configuration: sessionConfiguration)
    }

    deinit {
        session.invalidateAndCancel()
    }

    /// Sends a request to a bucket and returns the response body.
    @discardableResult
    func send(_ method: HTTPClient.Method, bucket: String) async throws -> Data {
        let path: Path = "/\(bucket)"
        if let component = path.invalidComponent {
            throw Exoscale.ClientError.invalidPathComponent(component)
        }
        try Task.checkCancellation()
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)!
        components.percentEncodedPath = path.encoded
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (data, response) = try await session.data(for: signer.sign(request))
        try Task.checkCancellation()
        guard let response = response as? HTTPURLResponse else {
            throw Exoscale.ClientError.invalidResponse
        }
        guard (200 ..< 300).contains(response.statusCode) else {
            throw Exoscale.S3Error(statusCode: response.statusCode, body: data)
        }
        return data
    }
}

public extension Exoscale {
    /// An unsuccessful response from the S3-compatible API of Simple Object Storage.
    struct S3Error: Error, Hashable, Sendable, LocalizedError {
        /// The HTTP status code, such as 409.
        public let statusCode: Int
        /// The S3 error code, such as `BucketNotEmpty`.
        public let code: String?
        /// The explanation returned by the API, when there is one.
        public let message: String?

        /// Creates an error, for example for previews and tests.
        public init(statusCode: Int, code: String? = nil, message: String? = nil) {
            self.statusCode = statusCode
            self.code = code
            self.message = message
        }

        /// Reads the code and message of an S3 XML error body.
        init(statusCode: Int, body: Data) {
            let text = String(decoding: body, as: UTF8.self)
            func element(_ name: String) -> String? {
                guard let start = text.range(of: "<\(name)>"),
                      let end = text.range(of: "</\(name)>", range: start.upperBound ..< text.endIndex)
                else { return nil }
                let value = text[start.upperBound ..< end.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                return value.isEmpty ? nil : value
            }
            self.init(statusCode: statusCode, code: element("Code"), message: element("Message"))
        }

        /// The API's explanation, or else the status.
        public var errorDescription: String? {
            if let message {
                return message
            }
            let reason = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            return ["Object Storage returned HTTP \(statusCode) (\(reason)).", code].compactMap(\.self)
                .joined(separator: " ")
        }
    }
}
