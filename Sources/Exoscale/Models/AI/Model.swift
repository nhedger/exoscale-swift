public extension Exoscale {
    /// AI model returned by the API.
    struct Model: Codable, Sendable {
        public enum State: String, Codable, Sendable {
            case ready
            case creating
            case downloading
            case error
            case created
        }

        public let updatedAt: String?
        public let name: String?
        public let state: State?
        public let id: String?
        public let modelSize: Int?
        public let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case name
            case state
            case id
            case modelSize = "model-size"
            case createdAt = "created-at"
        }
    }
}
