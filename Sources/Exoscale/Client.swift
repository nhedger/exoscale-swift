import Alamofire
import Foundation

public struct ExoscaleZone: RawRepresentable, Hashable, CaseIterable, Codable, Sendable {
    public let rawValue: String

    public static let atVie1 = ExoscaleZone(rawValue: "at-vie-1")
    public static let atVie2 = ExoscaleZone(rawValue: "at-vie-2")
    public static let bgSof1 = ExoscaleZone(rawValue: "bg-sof-1")
    public static let chDk2 = ExoscaleZone(rawValue: "ch-dk-2")
    public static let chGva2 = ExoscaleZone(rawValue: "ch-gva-2")
    public static let deFra1 = ExoscaleZone(rawValue: "de-fra-1")
    public static let deMuc1 = ExoscaleZone(rawValue: "de-muc-1")
    public static let hrZag1 = ExoscaleZone(rawValue: "hr-zag-1")

    public static let allCases: [ExoscaleZone] = [
        .atVie1,
        .atVie2,
        .bgSof1,
        .chDk2,
        .chGva2,
        .deFra1,
        .deMuc1,
        .hrZag1,
    ]

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public var apiEndpoint: URL {
        URL(string: "https://api-\(rawValue).exoscale.com/v2")!
    }
}

public final class ExoscaleClient {
    public let zone: ExoscaleZone
    public let baseURL: URL

    private let session: Session

    public convenience init(
        zone: ExoscaleZone
    ) throws {
        try self.init(
            credentials: ExoscaleCredentials(),
            zone: zone
        )
    }

    public init(
        credentials: ExoscaleCredentials,
        zone: ExoscaleZone
    ) {
        self.zone = zone
        self.baseURL = zone.apiEndpoint
        self.session = Session(
            configuration: .default,
            interceptor: ExoscaleRequestInterceptor(
                credentials: credentials
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

    public func get<Response: Decodable>(
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

    public func post<Response: Decodable>(
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

    public func put<Response: Decodable>(
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

    public func patch<Response: Decodable>(
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

    public func delete<Response: Decodable>(
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
