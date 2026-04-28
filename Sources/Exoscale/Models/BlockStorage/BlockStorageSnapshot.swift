public extension Exoscale {
    /// Block storage snapshot returned by the API.
    struct BlockStorageSnapshot: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?

            public init(id: String? = nil) {
                self.id = id
            }
        }

        public enum State: String, Codable, Sendable {
            case partiallyDestroyed = "partially-destroyed"
            case destroying
            case creating
            case created
            case promoting
            case error
            case destroyed
            case allocated
        }

        public let id: String?
        public let name: String?
        public let size: Int?
        public let volumeSize: Int?
        public let createdAt: String?
        public let state: State?
        public let labels: [String: String]?
        public let blockStorageVolume: Exoscale.BlockStorageVolume.Reference?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case size
            case volumeSize = "volume-size"
            case createdAt = "created-at"
            case state
            case labels
            case blockStorageVolume = "block-storage-volume"
        }
    }
}
