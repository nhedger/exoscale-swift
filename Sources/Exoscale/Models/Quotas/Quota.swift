public extension Exoscale {
    /// Organization quota returned by the API.
    struct Quota: Codable, Sendable {
        public let resource: String?
        public let usage: Int?
        public let limit: Int?
    }
}
