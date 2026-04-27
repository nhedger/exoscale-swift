public extension Exoscale {
    /// Infrastructure mutation event returned by the API.
    struct Event: Codable, Sendable {
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
        public let timestamp: String?
        public let pathParams: [String: Exoscale.JSONValue]?
        public let handler: String?
        public let message: String?

        enum CodingKeys: String, CodingKey {
            case iamUser = "iam-user"
            case requestID = "request-id"
            case iamRole = "iam-role"
            case zone
            case getParams = "get-params"
            case bodyParams = "body-params"
            case status
            case sourceIP = "source-ip"
            case iamAPIKey = "iam-api-key"
            case uri
            case elapsedMS = "elapsed-ms"
            case timestamp
            case pathParams = "path-params"
            case handler
            case message
        }
    }
}
