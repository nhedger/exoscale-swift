public extension Exoscale {
    /// An IP version.
    struct AddressFamily: RawRepresentable, Hashable, Codable, Sendable {
        /// The family as the API names it.
        public let rawValue: String

        /// Creates a family, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// IPv4.
        public static let ipv4 = AddressFamily(rawValue: "inet4")
        /// IPv6.
        public static let ipv6 = AddressFamily(rawValue: "inet6")
        /// IPv4 and IPv6.
        public static let dual = AddressFamily(rawValue: "dual")
    }

    /// How a health check tests an instance.
    struct HealthcheckMode: RawRepresentable, Hashable, Codable, Sendable {
        /// The mode as the API names it.
        public let rawValue: String

        /// Creates a mode, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// A TCP connection.
        public static let tcp = HealthcheckMode(rawValue: "tcp")
        /// An HTTP request.
        public static let http = HealthcheckMode(rawValue: "http")
        /// An HTTPS request.
        public static let https = HealthcheckMode(rawValue: "https")
    }
}
