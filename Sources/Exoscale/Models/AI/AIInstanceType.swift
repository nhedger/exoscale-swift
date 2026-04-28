public extension Exoscale {
    /// AI instance type availability returned by the API.
    struct AIInstanceType: Codable, Sendable {
        public let family: String?
        public let authorized: Bool?
    }
}
