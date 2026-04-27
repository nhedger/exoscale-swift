import Alamofire
import Foundation

enum Http {}

extension Http {
    final class Client {
        let baseURL: URL
        let userAgent: String?

        private let session: Session

        init(
            config: Exoscale.Config
        ) {
            self.baseURL = config.apiEndpoint
            self.userAgent = config.userAgent
            self.session = Session(
                configuration: .default,
                interceptor: Interceptor(
                    adapters: [
                        ApplyUserAgent(userAgent: config.userAgent),
                        ApplyJSONContentType(),
                        SignRequest(
                            apiKey: config.apiKey,
                            apiSecret: config.apiSecret
                        ),
                    ]
                )
            )
        }

        private func requestData(
            _ method: String,
            path: String,
            query: [String: String?] = [:],
            body: Data? = nil,
            headers: [String: String] = [:]
        ) async throws -> Data {
            let request = try makeRequest(
                method,
                path: path,
                query: query,
                body: body,
                headers: headers
            )

            return try await session
                .request(request)
                .validate()
                .serializingData()
                .value
        }

        private func decode<Response: Decodable>(
            _ data: Data,
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = JSONDecoder()
        ) throws -> Response {
            return try decoder.decode(type, from: data)
        }

        func get<Response: Decodable>(
            path: String,
            query: [String: String?] = [:],
            headers: [String: String] = [:],
            as type: Response.Type = Response.self,
            decoder: JSONDecoder = JSONDecoder()
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
            decoder: JSONDecoder = JSONDecoder()
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
            decoder: JSONDecoder = JSONDecoder()
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
            decoder: JSONDecoder = JSONDecoder()
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
            decoder: JSONDecoder = JSONDecoder()
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
            )

            components?.queryItems = query
                .map { URLQueryItem(name: $0.key, value: $0.value) }
                .sorted { $0.name < $1.name }

            guard let url = components?.url else {
                throw ExoscaleError.invalidRequestURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = method
            request.httpBody = body

            for (header, value) in headers {
                request.setValue(value, forHTTPHeaderField: header)
            }

            return request
        }
    }
}
