public extension Exoscale {
    /// Kubernetes audit logging configuration returned by the SKS API.
    struct SKSAudit: Codable, Hashable, Sendable {
        public let endpoint: String?
        public let enabled: Bool?
        public let initialBackoff: String?

        public init(
            endpoint: String? = nil,
            enabled: Bool? = nil,
            initialBackoff: String? = nil
        ) {
            self.endpoint = endpoint
            self.enabled = enabled
            self.initialBackoff = initialBackoff
        }
    }
}

extension Exoscale.SKSAudit {
    enum CodingKeys: String, CodingKey {
        case endpoint
        case enabled
        case initialBackoff = "initial-backoff"
    }
}
