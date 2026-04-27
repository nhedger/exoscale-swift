public extension Exoscale {
    /// SOS bucket usage returned by the API.
    struct SOSBucketUsage: Codable, Sendable {
        public let name: String?
        public let createdAt: String?
        public let zoneName: Exoscale.KnownZone?
        public let size: Int?

        enum CodingKeys: String, CodingKey {
            case name
            case createdAt = "created-at"
            case zoneName = "zone-name"
            case size
        }
    }
}
