public extension Exoscale {
    /// Block storage volume returned by the API.
    struct BlockStorageVolume: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?

            public init(id: String? = nil) {
                self.id = id
            }
        }

        public enum State: String, Codable, Sendable {
            case snapshotting
            case deleted
            case creating
            case detached
            case deleting
            case attaching
            case error
            case attached
            case detaching
        }

        public let labels: [String: String]?
        public let instance: Exoscale.Instance.Reference?
        public let name: String?
        public let state: State?
        public let size: Int?
        public let blockSize: Int?
        public let blockStorageSnapshots: [Exoscale.BlockStorageSnapshot.Reference]?
        public let id: String?
        public let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case labels
            case instance
            case name
            case state
            case size
            case blockSize = "blocksize"
            case blockStorageSnapshots = "block-storage-snapshots"
            case id
            case createdAt = "created-at"
        }
    }
}
