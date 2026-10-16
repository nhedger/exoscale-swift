import Foundation

public extension Exoscale {
    /// Infrastructure mutation event returned by the API.
    struct Event: Hashable, Sendable {
        public let iamUser: Exoscale.User?
        public let requestID: String?
        public let iamRole: Exoscale.Role?
        public let zone: String?
        public let getParams: [String: Exoscale.JSONValue]?
        public let bodyParams: [String: Exoscale.JSONValue]?
        public let status: Int?
        public let sourceIP: String?
        public let iamAPIKey: Exoscale.APIKey?
        public let uri: String?
        public let elapsedMS: Int?
        public let timestamp: Date?
        public let pathParams: [String: Exoscale.JSONValue]?
        public let handler: String?
        public let message: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            iamUser: Exoscale.User? = nil,
            requestID: String? = nil,
            iamRole: Exoscale.Role? = nil,
            zone: String? = nil,
            getParams: [String: Exoscale.JSONValue]? = nil,
            bodyParams: [String: Exoscale.JSONValue]? = nil,
            status: Int? = nil,
            sourceIP: String? = nil,
            iamAPIKey: Exoscale.APIKey? = nil,
            uri: String? = nil,
            elapsedMS: Int? = nil,
            timestamp: Date? = nil,
            pathParams: [String: Exoscale.JSONValue]? = nil,
            handler: String? = nil,
            message: String? = nil
        ) {
            self.iamUser = iamUser
            self.requestID = requestID
            self.iamRole = iamRole
            self.zone = zone
            self.getParams = getParams
            self.bodyParams = bodyParams
            self.status = status
            self.sourceIP = sourceIP
            self.iamAPIKey = iamAPIKey
            self.uri = uri
            self.elapsedMS = elapsedMS
            self.timestamp = timestamp
            self.pathParams = pathParams
            self.handler = handler
            self.message = message
        }

        init(data: Payload, client: Http.Client) {
            iamUser = data.iamUser.map { Exoscale.User(data: $0, client: client) }
            requestID = data.requestID
            iamRole = data.iamRole.map { Exoscale.Role(data: $0, client: client) }
            zone = data.zone
            getParams = data.getParams
            bodyParams = data.bodyParams
            status = data.status
            sourceIP = data.sourceIP
            iamAPIKey = data.iamAPIKey.map { Exoscale.APIKey(data: $0, client: client) }
            uri = data.uri
            elapsedMS = data.elapsedMS
            timestamp = data.timestamp
            pathParams = data.pathParams
            handler = data.handler
            message = data.message
        }
    }
}
