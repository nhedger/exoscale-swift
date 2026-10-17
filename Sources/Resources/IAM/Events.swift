import Foundation

public extension Exoscale {
    /// A request that changed something through the API, from the organization's audit trail.
    struct Event: Hashable, Codable, Sendable {
        /// The request's identifier.
        public let requestID: String?
        /// When the request was made.
        public let timestamp: Date?
        /// The zone the request was sent to.
        public let zone: String?
        /// The operation called, such as `create-instance`.
        public let handler: String?
        /// The request URI.
        public let uri: String?
        /// The HTTP status of the response.
        public let status: Int?
        /// The response message.
        public let message: String?
        /// The address the request came from.
        public let sourceIP: String?
        /// How long the request took, in milliseconds.
        public let elapsedMilliseconds: Int?
        /// The user who made the request.
        public let user: User?
        /// The role the request was made with.
        public let role: Role?
        /// The API key the request was made with.
        public let apiKey: APIKey?
        /// The path parameters.
        public let pathParameters: [String: JSONValue]?
        /// The query parameters.
        public let queryParameters: [String: JSONValue]?
        /// The body parameters.
        public let bodyParameters: [String: JSONValue]?

        /// Creates an event, for example for previews and tests.
        public init(
            requestID: String? = nil,
            timestamp: Date? = nil,
            zone: String? = nil,
            handler: String? = nil,
            uri: String? = nil,
            status: Int? = nil,
            message: String? = nil,
            sourceIP: String? = nil,
            elapsedMilliseconds: Int? = nil,
            user: User? = nil,
            role: Role? = nil,
            apiKey: APIKey? = nil,
            pathParameters: [String: JSONValue]? = nil,
            queryParameters: [String: JSONValue]? = nil,
            bodyParameters: [String: JSONValue]? = nil
        ) {
            self.requestID = requestID
            self.timestamp = timestamp
            self.zone = zone
            self.handler = handler
            self.uri = uri
            self.status = status
            self.message = message
            self.sourceIP = sourceIP
            self.elapsedMilliseconds = elapsedMilliseconds
            self.user = user
            self.role = role
            self.apiKey = apiKey
            self.pathParameters = pathParameters
            self.queryParameters = queryParameters
            self.bodyParameters = bodyParameters
        }

        enum CodingKeys: String, CodingKey {
            case timestamp, zone, handler, uri, status, message
            case requestID = "request-id"
            case sourceIP = "source-ip"
            case elapsedMilliseconds = "elapsed-ms"
            case user = "iam-user"
            case role = "iam-role"
            case apiKey = "iam-api-key"
            case pathParameters = "path-params"
            case queryParameters = "get-params"
            case bodyParameters = "body-params"
        }
    }

    /// The organization's audit trail of requests that changed something through the API.
    struct Events: Sendable {
        let client: HTTPClient

        /// Lists the requests made in a time range. The API defaults to the last 24 hours.
        public func list(from: Date? = nil, to: Date? = nil) async throws -> [Event] {
            try await client.send(.get, "/event", query: [
                "from": from?.formatted(.iso8601),
                "to": to?.formatted(.iso8601)
            ])
        }
    }
}
