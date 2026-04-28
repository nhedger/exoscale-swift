public extension Exoscale {
    /// SSH key returned by the API.
    struct SSHKey: Codable, Sendable {
        public let name: String?
        public let fingerprint: String?
    }
}
