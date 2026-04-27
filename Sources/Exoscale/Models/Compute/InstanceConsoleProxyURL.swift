public extension Exoscale {
    /// Signed console proxy URL returned by the API for a compute instance.
    struct InstanceConsoleProxyURL: Codable, Sendable {
        public let url: String?
        public let host: String?
        public let path: String?
    }
}
