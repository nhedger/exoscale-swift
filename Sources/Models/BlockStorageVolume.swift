import Foundation

public extension Exoscale {
    /// Block storage volume returned by the API.
    struct BlockStorageVolume: Hashable, Sendable {
        public let labels: [String: String]?
        public let instance: Exoscale.Instance.Reference?
        public let name: String?
        public let state: State?
        public let size: Int?
        public let encrypted: Bool?
        public let blockSize: Int?
        public let blockStorageSnapshots: [Exoscale.BlockStorageSnapshot.Reference]?
        public let id: String?
        public let createdAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            labels: [String: String]? = nil,
            instance: Exoscale.Instance.Reference? = nil,
            name: String? = nil,
            state: State? = nil,
            size: Int? = nil,
            encrypted: Bool? = nil,
            blockSize: Int? = nil,
            blockStorageSnapshots: [Exoscale.BlockStorageSnapshot.Reference]? = nil,
            id: String? = nil,
            createdAt: Date? = nil
        ) {
            self.labels = labels
            self.instance = instance
            self.name = name
            self.state = state
            self.size = size
            self.encrypted = encrypted
            self.blockSize = blockSize
            self.blockStorageSnapshots = blockStorageSnapshots
            self.id = id
            self.createdAt = createdAt
        }

        init(data: Payload, client _: Http.Client) {
            labels = data.labels
            instance = data.instance
            name = data.name
            state = data.state
            size = data.size
            encrypted = data.encrypted
            blockSize = data.blockSize
            blockStorageSnapshots = data.blockStorageSnapshots
            id = data.id
            createdAt = data.createdAt
        }
    }
}

public extension Exoscale.BlockStorageVolume {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?

        public init(id: String? = nil) {
            self.id = id
        }
    }
}

public extension Exoscale.BlockStorageVolume {
    enum State: Exoscale.ExtensibleEnum {
        case snapshotting
        case deleted
        case creating
        case detached
        case deleting
        case attaching
        case error
        case attached
        case detaching
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .snapshotting,
            .deleted,
            .creating,
            .detached,
            .deleting,
            .attaching,
            .error,
            .attached,
            .detaching
        ]

        public var rawValue: String {
            switch self {
            case .snapshotting: "snapshotting"
            case .deleted: "deleted"
            case .creating: "creating"
            case .detached: "detached"
            case .deleting: "deleting"
            case .attaching: "attaching"
            case .error: "error"
            case .attached: "attached"
            case .detaching: "detaching"
            case let .unknown(value): value
            }
        }
    }
}
