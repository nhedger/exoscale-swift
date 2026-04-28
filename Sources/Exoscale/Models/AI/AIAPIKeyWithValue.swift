public extension Exoscale {
    /// AI API key including its plaintext value.
    struct AIAPIKeyWithValue: Codable, Sendable {
        public let updatedAt: String?
        public let name: String?
        public let scope: String?
        public let id: String?
        public let orgUUID: String?
        public let createdAt: String?
        public let value: String?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case name
            case scope
            case id
            case orgUUID = "org-uuid"
            case createdAt = "created-at"
            case value
        }
    }
}
