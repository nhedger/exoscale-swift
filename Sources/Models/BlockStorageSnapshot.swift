import Foundation

public extension Exoscale {
    /// Block storage snapshot returned by the API.
    struct BlockStorageSnapshot: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let size: Int?
        public let volumeSize: Int?
        public let createdAt: Date?
        public let state: State?
        public let labels: [String: String]?
        public let blockStorageVolume: Exoscale.BlockStorageVolume.Reference?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            size: Int? = nil,
            volumeSize: Int? = nil,
            createdAt: Date? = nil,
            state: State? = nil,
            labels: [String: String]? = nil,
            blockStorageVolume: Exoscale.BlockStorageVolume.Reference? = nil
        ) {
            self.id = id
            self.name = name
            self.size = size
            self.volumeSize = volumeSize
            self.createdAt = createdAt
            self.state = state
            self.labels = labels
            self.blockStorageVolume = blockStorageVolume
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            size = data.size
            volumeSize = data.volumeSize
            createdAt = data.createdAt
            state = data.state
            labels = data.labels
            blockStorageVolume = data.blockStorageVolume
        }
    }
}

public extension Exoscale.BlockStorageSnapshot {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?

        public init(id: String? = nil) {
            self.id = id
        }
    }
}

public extension Exoscale.BlockStorageSnapshot {
    enum State: Exoscale.ExtensibleEnum {
        case partiallyDestroyed
        case destroying
        case creating
        case created
        case promoting
        case error
        case destroyed
        case allocated
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .partiallyDestroyed,
            .destroying,
            .creating,
            .created,
            .promoting,
            .error,
            .destroyed,
            .allocated
        ]

        public var rawValue: String {
            switch self {
            case .partiallyDestroyed: "partially-destroyed"
            case .destroying: "destroying"
            case .creating: "creating"
            case .created: "created"
            case .promoting: "promoting"
            case .error: "error"
            case .destroyed: "destroyed"
            case .allocated: "allocated"
            case let .unknown(value): value
            }
        }
    }
}
