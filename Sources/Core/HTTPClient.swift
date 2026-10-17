import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Sends signed requests to the API of one zone and decodes the responses.
final class HTTPClient: Sendable {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    let endpoint: URL
    let userAgent: String
    private let signer: RequestSigner
    private let session: URLSession

    init(configuration: Exoscale.Configuration, sessionConfiguration: URLSessionConfiguration) throws {
        guard let endpoint = configuration.zone.apiEndpoint else {
            throw Exoscale.ClientError.invalidZone(configuration.zone.rawValue)
        }
        self.endpoint = endpoint
        userAgent = configuration.userAgent
        signer = RequestSigner(apiKey: configuration.apiKey, apiSecret: configuration.apiSecret)
        session = URLSession(configuration: sessionConfiguration)
    }

    deinit {
        session.invalidateAndCancel()
    }

    /// Sends a request and decodes its response.
    func send<Response: Decodable>(
        _ method: Method,
        _ path: Path,
        query: [String: String?] = [:],
        body: (any Encodable & Sendable)? = nil,
        as _: Response.Type = Response.self
    ) async throws -> Response {
        try await makeDecoder().decode(Response.self, from: data(method, path, query: query, body: body))
    }

    /// Sends a request whose response has no body, such as a 204.
    func send(
        _ method: Method,
        _ path: Path,
        query: [String: String?] = [:],
        body: (any Encodable & Sendable)? = nil
    ) async throws {
        _ = try await data(method, path, query: query, body: body)
    }

    /// Sends a request and decodes the value under `key` in its response, such as the list in
    /// `{"instances": [...]}`. A missing key gives an empty list.
    func send<Item: Decodable>(
        _ method: Method,
        _ path: Path,
        query: [String: String?] = [:],
        body: (any Encodable & Sendable)? = nil,
        unwrapping key: String
    ) async throws -> [Item] {
        let decoder = makeDecoder()
        decoder.userInfo[Unwrapped<[Item]>.keyInfo] = key
        return try await decoder.decode(
            Unwrapped<[Item]>.self,
            from: data(method, path, query: query, body: body)
        ).value ?? []
    }

    /// The key under which decoders hold the client, so decoded operations can poll themselves.
    static let userInfoKey = CodingUserInfoKey(rawValue: "exoscale.http-client")!

    /// A decoder for this client's responses.
    private func makeDecoder() -> JSONDecoder {
        let decoder = JSON.decoder()
        decoder.userInfo[Self.userInfoKey] = self
        return decoder
    }

    /// Sends a request and returns the validated response body.
    func data(
        _ method: Method,
        _ path: Path,
        query: [String: String?] = [:],
        body: (any Encodable & Sendable)? = nil
    ) async throws -> Data {
        try Task.checkCancellation()
        let request = try signer.sign(makeRequest(method, path, query: query, body: body))
        let (data, response) = try await session.data(for: request)
        try Task.checkCancellation()

        guard let response = response as? HTTPURLResponse else {
            throw Exoscale.ClientError.invalidResponse
        }
        guard (200 ..< 300).contains(response.statusCode) else {
            throw Exoscale.APIError(
                statusCode: response.statusCode,
                body: data,
                retryAfterHeader: response.value(forHTTPHeaderField: "Retry-After")
            )
        }
        // An omitted Content-Type is accepted; decoding still checks the body.
        if !data.isEmpty, let contentType = response.value(forHTTPHeaderField: "Content-Type") {
            let mediaType = contentType.prefix { $0 != ";" }.trimmingCharacters(in: .whitespaces).lowercased()
            guard mediaType == "application/json" ||
                (mediaType.hasPrefix("application/") && mediaType.hasSuffix("+json"))
            else {
                throw Exoscale.ClientError.unexpectedContentType(contentType)
            }
        }
        return data
    }

    func makeRequest(
        _ method: Method,
        _ path: Path,
        query: [String: String?] = [:],
        body: (any Encodable & Sendable)? = nil
    ) throws -> URLRequest {
        if let component = path.invalidComponent {
            throw Exoscale.ClientError.invalidPathComponent(component)
        }
        // The endpoint is a valid URL, so its components always parse.
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)!
        components.percentEncodedPath += path.encoded

        // Parameters without a value are left out, and values are escaped strictly: the API
        // form-decodes query strings, so a literal `+` would arrive as a space.
        let items = query
            .compactMap { name, value in value.map { URLQueryItem(name: Self.escape(name), value: Self.escape($0)) } }
            .sorted { $0.name < $1.name }
        if !items.isEmpty {
            components.percentEncodedQueryItems = items
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let body {
            request.httpBody = try JSON.encoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }

    /// RFC 3986 unreserved characters, the only ones Go's `url.QueryEscape` leaves unescaped.
    private static let unreserved = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    )

    private static func escape(_ value: String) -> String {
        // Swift strings are valid Unicode, so percent-encoding can't fail.
        value.addingPercentEncoding(withAllowedCharacters: unreserved)!
    }
}
