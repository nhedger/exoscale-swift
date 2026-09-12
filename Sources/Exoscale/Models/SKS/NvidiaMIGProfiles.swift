public extension Exoscale {
    /// GPU partition profiles for SKS nodepools, keyed by GPU model.
    struct NvidiaMIGProfiles: Codable, Sendable {
        public let a30: String?
        public let rtxPro6000: String?
        public let b300: String?

        public init(a30: String? = nil, rtxPro6000: String? = nil, b300: String? = nil) {
            self.a30 = a30
            self.rtxPro6000 = rtxPro6000
            self.b300 = b300
        }

        enum CodingKeys: String, CodingKey {
            case a30 = "a30.24gb"
            case rtxPro6000 = "rtxpro6000.96gb"
            case b300 = "b300.269gb"
        }
    }
}
