public extension Exoscale {
    /// Transient password returned by the API for a compute instance.
    struct InstancePassword: Codable, Sendable {
        public let password: String?
    }
}
