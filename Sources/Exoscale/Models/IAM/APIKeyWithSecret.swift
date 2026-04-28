public extension Exoscale {
    /// IAM API key including its secret value.
    struct APIKeyWithSecret: Codable, Sendable {
        public let name: String?
        public let key: String?
        public let secret: String?
        public let roleID: String?

        enum CodingKeys: String, CodingKey {
            case name
            case key
            case secret
            case roleID = "role-id"
        }
    }
}
