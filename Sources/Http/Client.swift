import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

enum Http {}

extension Http {
    final class Client: Hashable, Sendable {
        let baseURL: URL
        let userAgent: String?

        private let session: URLSession
        private let signer: SignRequest

        init(
            config: Exoscale.Config,
            sessionConfiguration: URLSessionConfiguration = .default
        ) {
            baseURL = config.apiEndpoint
            userAgent = config.userAgent
            session = URLSession(configuration: sessionConfiguration)
            signer = SignRequest(apiKey: config.apiKey, apiSecret: config.apiSecret)
        }

        deinit {
            session.invalidateAndCancel()
        }

        /// Executes an API operation and binds its result to this client.
        func execute<Operation: HttpOperation>(_ operation: Operation) async throws -> Operation.Response.Result {
            try Task.checkCancellation()
            let request = try operation.request.resolve()
            let data = try await requestData(
                request.method.rawValue,
                path: request.path,
                query: request.query,
                body: request.body,
                headers: request.headers
            )
            let payload = try decode(data, as: Operation.Response.Payload.self)
            try Task.checkCancellation()
            return try operation.createResponse(payload).transform(client: self)
        }

        private func requestData(
            _ method: String,
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:]
        ) async throws -> Data {
            try Task.checkCancellation()
            var request = try makeRequest(
                method,
                path: path,
                query: query,
                body: body,
                headers: headers
            )

            request = try ApplyUserAgent(userAgent: userAgent ?? "").adapt(request)
            request = try ApplyJSONContentType().adapt(request)
            if request.value(forHTTPHeaderField: "Accept") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Accept")
            }
            request = try signer.adapt(request)

            let (data, response) = try await session.data(for: request)
            try Task.checkCancellation()
            guard let response = response as? HTTPURLResponse else {
                throw Exoscale.ApiError.invalidResponse
            }
            if let error = Self.error(
                forResponseStatusCode: response.statusCode,
                data: data,
                retryAfter: response.value(forHTTPHeaderField: "Retry-After")
            ) {
                throw error
            }

            // Empty responses and omitted Content-Type headers are accepted; decoding
            // still validates any response body against the requested model.
            if !data.isEmpty, let contentType = response.value(forHTTPHeaderField: "Content-Type") {
                let mimeType = contentType.components(separatedBy: ";")[0]
                    .trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                guard mimeType == "application/json"
                    || (mimeType.hasPrefix("application/") && mimeType.hasSuffix("+json"))
                else {
                    throw Exoscale.ApiError.unexpectedContentType(contentType)
                }
            }
            return data
        }

        /// Clients are equal only to themselves, so models compare equal when they come from the
        /// same account and zone.
        static func == (lhs: Client, rhs: Client) -> Bool {
            lhs === rhs
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }

        /// - Parameter retryAfter: The response's `Retry-After` header, if any.
        static func error(
            forResponseStatusCode statusCode: Int,
            data: Data? = nil,
            retryAfter: String? = nil
        ) -> Exoscale.ApiError? {
            switch statusCode {
            case 401:
                .unauthorized(message: Exoscale.ApiError.message(in: data))
            case 403:
                if let data, String(data: data, encoding: .utf8)?.contains("Forbidden by role policy") == true {
                    .forbiddenByPolicy(message: Exoscale.ApiError.message(in: data))
                } else {
                    .forbidden(message: Exoscale.ApiError.message(in: data))
                }
            case 429:
                .rateLimited(
                    message: Exoscale.ApiError.message(in: data),
                    retryAfter: Exoscale.ApiError.retryAfter(header: retryAfter, body: data)
                )
            case 503:
                .serviceUnavailable(
                    message: Exoscale.ApiError.message(in: data),
                    retryAfter: Exoscale.ApiError.retryAfter(header: retryAfter, body: data)
                )
            case 200 ..< 300:
                nil
            default:
                .httpError(statusCode: statusCode, body: data ?? Data())
            }
        }

        private func decode<Response: Decodable>(
            _ data: Data,
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) throws -> Response {
            if data.isEmpty, let empty = EmptyResponse() as? Response {
                return empty
            }
            return try decoder.decode(type, from: data)
        }

        func get<Response: Decodable>(
            path: Http.Path,
            query: [String: String?] = [:],
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try await decode(
                requestData("GET", path: path, query: query, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func post<Response: Decodable>(
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try await decode(
                requestData("POST", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func put<Response: Decodable>(
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try await decode(
                requestData("PUT", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func patch<Response: Decodable>(
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try await decode(
                requestData("PATCH", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func delete<Response: Decodable>(
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try await decode(
                requestData("DELETE", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func makeRequest(
            _ method: String,
            path: Http.Path,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:]
        ) throws -> URLRequest {
            if let value = path.invalidValue {
                throw Exoscale.ApiError.invalidPathValue(value)
            }
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            components.percentEncodedPath += path.percentEncoded.hasPrefix("/")
                ? path.percentEncoded
                : "/" + path.percentEncoded

            // Optional parameters without a value are omitted rather than sent as bare names.
            let queryItems = query
                .compactMap { name, value in value.map { (name: name, value: $0) } }
                .sorted { $0.name < $1.name }
                .map {
                    URLQueryItem(
                        name: Self.percentEncodedQueryComponent($0.name),
                        value: Self.percentEncodedQueryComponent($0.value)
                    )
                }
            if !queryItems.isEmpty {
                components.percentEncodedQueryItems = queryItems
            }

            var request = URLRequest(url: components.url!)
            request.httpMethod = method
            request.httpBody = body

            for (header, value) in headers {
                request.setValue(value, forHTTPHeaderField: header)
            }

            return request
        }

        /// RFC 3986 unreserved characters, the only ones left unescaped by Go's `url.QueryEscape`.
        private static let unreservedQueryCharacters = CharacterSet(
            charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        )

        /// Escapes everything outside the unreserved set. The API form-decodes query strings, so
        /// a literal `+` would arrive as a space and no longer match the signed value.
        private static func percentEncodedQueryComponent(_ value: String) -> String {
            // Swift strings are always valid Unicode, so percent encoding cannot fail.
            value.addingPercentEncoding(withAllowedCharacters: unreservedQueryCharacters)!
        }
    }
}
