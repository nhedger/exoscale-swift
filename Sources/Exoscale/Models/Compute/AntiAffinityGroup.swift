public extension Exoscale {
    /// Anti-affinity group returned by the API.
    struct AntiAffinityGroup: Codable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        public let instances: [Exoscale.Instance]?
    }
}
