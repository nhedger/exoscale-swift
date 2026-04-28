import Alamofire
import CryptoKit
import Foundation

/// Signs outgoing requests with Exoscale's `EXO2-HMAC-SHA256` authorization scheme.
struct SignRequest: RequestInterceptor, Sendable {
    let apiKey: String
    let apiSecret: String
    let expirationInterval: TimeInterval

    private let now: @Sendable () -> Date

    /// Creates an interceptor that signs requests with the provided credentials.
    ///
    /// - Parameters:
    ///   - apiKey: The Exoscale API key used to produce the authorization header.
    ///   - apiSecret: The Exoscale API secret used to produce the HMAC signature.
    ///   - expirationInterval: The signature validity window, in seconds.
    ///   - now: The clock used to compute request expiry timestamps.
    init(
        apiKey: String,
        apiSecret: String,
        expirationInterval: TimeInterval = 600,
        now: @escaping @Sendable () -> Date = Date.init
    ) {
        self.apiKey = apiKey
        self.apiSecret = apiSecret
        self.expirationInterval = expirationInterval
        self.now = now
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping @Sendable (Result<URLRequest, any Error>) -> Void
    ) {
        do {
            completion(.success(try adapt(urlRequest)))
        } catch {
            completion(.failure(error))
        }
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: any Error,
        completion: @escaping @Sendable (RetryResult) -> Void
    ) {
        completion(.doNotRetry)
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let url = urlRequest.url!
        let expires = Int(now().addingTimeInterval(expirationInterval).timeIntervalSince1970)
        let signedQueryArguments = Self.signedQueryArguments(for: url)
        let signature = signature(
            for: urlRequest,
            url: url,
            signedQueryArguments: signedQueryArguments,
            expires: expires
        )

        var request = urlRequest
        var authorization = [
            "EXO2-HMAC-SHA256 credential=\(apiKey)",
        ]

        if !signedQueryArguments.names.isEmpty {
            authorization.append("signed-query-args=\(signedQueryArguments.names.joined(separator: ";"))")
        }

        authorization.append("expires=\(expires)")
        authorization.append("signature=\(signature)")
        request.setValue(authorization.joined(separator: ","), forHTTPHeaderField: "Authorization")

        return request
    }

    private func signature(
        for request: URLRequest,
        url: URL,
        signedQueryArguments: (names: [String], values: String),
        expires: Int
    ) -> String {
        let method = (request.httpMethod ?? HTTPMethod.get.rawValue).uppercased()
        let percentEncodedPath = URLComponents(url: url, resolvingAgainstBaseURL: false)?.percentEncodedPath ?? url.path
        let path = percentEncodedPath.isEmpty ? "/" : percentEncodedPath
        let body = request.httpBody ?? Data()

        let message = Self.messageData(segments: [
            Data("\(method) \(path)".utf8),
            body,
            Data(signedQueryArguments.values.utf8),
            Data(),
            Data(String(expires).utf8),
        ])

        let key = SymmetricKey(data: Data(apiSecret.utf8))
        let digest = HMAC<SHA256>.authenticationCode(for: message, using: key)
        return Data(digest).base64EncodedString()
    }

    private static func signedQueryArguments(for url: URL) -> (names: [String], values: String) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            !queryItems.isEmpty
        else {
            return ([], "")
        }

        var grouped = [String: [String]]()
        for item in queryItems {
            grouped[item.name, default: []].append(item.value ?? "")
        }

        let names = grouped.keys.filter { grouped[$0]?.count == 1 }.sorted()
        let values = names.compactMap { grouped[$0]?.first }.joined()

        return (names, values)
    }

    private static func messageData(segments: [Data]) -> Data {
        var message = Data()

        for (index, segment) in segments.enumerated() {
            if index > 0 {
                message.append(0x0A)
            }

            message.append(segment)
        }

        return message
    }
}
