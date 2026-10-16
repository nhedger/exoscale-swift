import Foundation

public extension Exoscale {
    /// Compute instance snapshot returned by the API.
    struct Snapshot: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let createdAt: Date?
        public let state: State?
        public let size: Int?
        public let export: Export?
        public let instance: Exoscale.Instance?
        public let applicationConsistent: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            createdAt: Date? = nil,
            state: State? = nil,
            size: Int? = nil,
            export: Export? = nil,
            instance: Exoscale.Instance? = nil,
            applicationConsistent: Bool? = nil
        ) {
            self.id = id
            self.name = name
            self.createdAt = createdAt
            self.state = state
            self.size = size
            self.export = export
            self.instance = instance
            self.applicationConsistent = applicationConsistent
        }

        init(data: Payload, client: Http.Client) {
            id = data.id
            name = data.name
            createdAt = data.createdAt
            state = data.state
            size = data.size
            export = data.export
            instance = data.instance.map { Exoscale.Instance(data: $0, client: client) }
            applicationConsistent = data.applicationConsistent
        }
    }
}

extension Exoscale.Snapshot.Export {
    enum CodingKeys: String, CodingKey {
        case id
        case presignedURL = "presigned-url"
        case md5sum
    }
}

public extension Exoscale.Snapshot {
    struct Export: Codable, Hashable, Sendable {
        public let id: String?
        public let presignedURL: String?
        public let md5sum: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            presignedURL: String? = nil,
            md5sum: String? = nil
        ) {
            self.id = id
            self.presignedURL = presignedURL
            self.md5sum = md5sum
        }
    }
}

public extension Exoscale.Snapshot {
    enum State: Exoscale.ExtensibleEnum {
        case snapshotting
        case deleted
        case exporting
        case ready
        case deleting
        case error
        case exported
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.snapshotting, .deleted, .exporting, .ready, .deleting, .error, .exported]

        public var rawValue: String {
            switch self {
            case .snapshotting: "snapshotting"
            case .deleted: "deleted"
            case .exporting: "exporting"
            case .ready: "ready"
            case .deleting: "deleting"
            case .error: "error"
            case .exported: "exported"
            case let .unknown(value): value
            }
        }
    }
}
