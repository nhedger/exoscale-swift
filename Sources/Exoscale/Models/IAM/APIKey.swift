public extension Exoscale {
    /// IAM API key metadata returned by the API.
    struct APIKey: Codable, Sendable {
        public let name: String?
        public let key: String?
        public let roleID: String?

        enum CodingKeys: String, CodingKey {
            case name
            case key
            case roleID = "role-id"
        }
    }
}
