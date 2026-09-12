import Foundation

enum Http {}

extension Http {
    final class Client: Sendable {
        let baseURL: URL
        let userAgent: String?

        private let session: URLSession
        private let signer: SignRequest

        init(
            config: Exoscale.Config,
            sessionConfiguration: URLSessionConfiguration = .default
        ) {
            self.baseURL = config.apiEndpoint
            self.userAgent = config.userAgent
            self.session = URLSession(configuration: sessionConfiguration)
            self.signer = SignRequest(apiKey: config.apiKey, apiSecret: config.apiSecret)
        }

        deinit {
            session.invalidateAndCancel()
        }

        private func requestData(
            _ method: String,
            path: String,
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
            if let error = Self.error(forResponseStatusCode: response.statusCode, data: data) {
                throw error
            }

            // Empty responses and omitted Content-Type headers are accepted; decoding
            // still validates any response body against the requested model.
            if !data.isEmpty, let contentType = response.value(forHTTPHeaderField: "Content-Type") {
                let mimeType = contentType.components(separatedBy: ";")[0]
                    .trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                guard mimeType == "application/json"
                    || (mimeType.hasPrefix("application/") && mimeType.hasSuffix("+json")) else {
                    throw Exoscale.ApiError.unexpectedContentType(contentType)
                }
            }
            return data
        }

        static func error(forResponseStatusCode statusCode: Int, data: Data? = nil) -> Exoscale.ApiError? {
            switch statusCode {
            case 401:
                .unauthorized
            case 403:
                if let data,
                   let message = String(data: data, encoding: .utf8),
                   message.contains("Forbidden by role policy") {
                    .forbiddenByPolicy
                } else {
                    .forbidden
                }
            case 200..<300:
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
            path: String,
            query: [String: String?] = [:],
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try decode(
                await requestData("GET", path: path, query: query, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func post<Response: Decodable>(
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try decode(
                await requestData("POST", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func put<Response: Decodable>(
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try decode(
                await requestData("PUT", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func patch<Response: Decodable>(
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try decode(
                await requestData("PATCH", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func delete<Response: Decodable>(
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = Exoscale.jsonDecoder()
        ) async throws -> Response {
            try decode(
                await requestData("DELETE", path: path, query: query, body: body, headers: headers),
                as: type,
                decoder: decoder
            )
        }

        func makeRequest(
            _ method: String,
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:]
        ) throws -> URLRequest {
            var components = URLComponents(
                url: path
                    .split(separator: "/")
                    .map(String.init)
                    .reduce(baseURL) { partialURL, pathComponent in
                        partialURL.appendingPathComponent(pathComponent)
                    },
                resolvingAgainstBaseURL: false
            )!

            components.queryItems = query
                .map { URLQueryItem(name: $0.key, value: $0.value) }
                .sorted { $0.name < $1.name }

            var request = URLRequest(url: components.url!)
            request.httpMethod = method
            request.httpBody = body

            for (header, value) in headers {
                request.setValue(value, forHTTPHeaderField: header)
            }

            return request
        }
    }
}
