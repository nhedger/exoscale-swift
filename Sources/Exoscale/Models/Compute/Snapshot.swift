public extension Exoscale {
    /// Compute instance snapshot returned by the API.
    struct Snapshot: Codable, Sendable {
        public struct Export: Codable, Sendable {
            public let id: String?
            public let presignedURL: String?
            public let md5sum: String?

            enum CodingKeys: String, CodingKey {
                case id
                case presignedURL = "presigned-url"
                case md5sum
            }
        }

        public enum State: String, Codable, Sendable {
            case snapshotting
            case deleted
            case exporting
            case ready
            case deleting
            case error
            case exported
        }

        public let id: String?
        public let name: String?
        public let createdAt: String?
        public let state: State?
        public let size: Int?
        public let export: Export?
        public let instance: Exoscale.Instance?
        public let applicationConsistent: Bool?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case createdAt = "created-at"
            case state
            case size
            case export
            case instance
            case applicationConsistent = "application-consistent"
        }
    }
}
