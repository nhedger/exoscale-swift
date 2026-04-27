public extension Exoscale {
    /// DNS domain returned by the API.
    struct Domain: Codable, Sendable {
        public let id: String?
        public let createdAt: String?
        public let unicodeName: String?

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created-at"
            case unicodeName = "unicode-name"
        }
    }
}
