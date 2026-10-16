import Foundation

public extension Exoscale {
    /// KMS key returned by the API.
    struct KMSKey: Hashable, Sendable {
        public let zone: String?
        public let description: String?
        public let rotation: RotationConfig?
        public let revision: Revision?
        public let name: String?
        public let multiZone: Bool?
        public let source: Source?
        public let usage: Usage?
        public let replicasStatus: [ReplicaState]?
        public let status: Status?
        public let statusSince: Date?
        public let id: String?
        public let replicas: [String]?
        public let material: Material?
        public let originZone: String?
        public let createdAt: Date?

        public let deleteAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            zone: String? = nil,
            description: String? = nil,
            rotation: RotationConfig? = nil,
            revision: Revision? = nil,
            name: String? = nil,
            multiZone: Bool? = nil,
            source: Source? = nil,
            usage: Usage? = nil,
            replicasStatus: [ReplicaState]? = nil,
            status: Status? = nil,
            statusSince: Date? = nil,
            id: String? = nil,
            replicas: [String]? = nil,
            material: Material? = nil,
            originZone: String? = nil,
            createdAt: Date? = nil,
            deleteAt: Date? = nil
        ) {
            self.zone = zone
            self.description = description
            self.rotation = rotation
            self.revision = revision
            self.name = name
            self.multiZone = multiZone
            self.source = source
            self.usage = usage
            self.replicasStatus = replicasStatus
            self.status = status
            self.statusSince = statusSince
            self.id = id
            self.replicas = replicas
            self.material = material
            self.originZone = originZone
            self.createdAt = createdAt
            self.deleteAt = deleteAt
        }

        init(data: Payload, client _: Http.Client) {
            zone = data.zone
            description = data.description
            rotation = data.rotation
            revision = data.revision
            name = data.name
            multiZone = data.multiZone
            source = data.source
            usage = data.usage
            replicasStatus = data.replicasStatus
            status = data.status
            statusSince = data.statusSince
            id = data.id
            replicas = data.replicas
            material = data.material
            originZone = data.originZone
            createdAt = data.createdAt
            deleteAt = data.deleteAt
        }
    }
}

public extension Exoscale.KMSKey {
    enum Usage: Exoscale.ExtensibleEnum {
        case encryptDecrypt
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.encryptDecrypt]

        public var rawValue: String {
            switch self {
            case .encryptDecrypt: "encrypt-decrypt"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.KMSKey {
    enum Source: Exoscale.ExtensibleEnum {
        case exoscaleKMS
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.exoscaleKMS]

        public var rawValue: String {
            switch self {
            case .exoscaleKMS: "exoscale-kms"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.KMSKey {
    enum Status: Exoscale.ExtensibleEnum {
        case enabled
        case disabled
        case pendingDeletion
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.enabled, .disabled, .pendingDeletion]

        public var rawValue: String {
            switch self {
            case .enabled: "enabled"
            case .disabled: "disabled"
            case .pendingDeletion: "pending-deletion"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.KMSKey {
    enum ActionStatus: Exoscale.ExtensibleEnum {
        case success
        case alreadyApplied
        case targetRegistered
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.success, .alreadyApplied, .targetRegistered]

        public var rawValue: String {
            switch self {
            case .success: "success"
            case .alreadyApplied: "already-applied"
            case .targetRegistered: "target-registered"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.KMSKey {
    struct Revision: Codable, Hashable, Sendable {
        public let at: Date?
        public let seq: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            at: Date? = nil,
            seq: Int? = nil
        ) {
            self.at = at
            self.seq = seq
        }
    }
}

extension Exoscale.KMSKey.RotationConfig {
    enum CodingKeys: String, CodingKey {
        case manualCount = "manual-count"
        case automatic
        case rotationPeriod = "rotation-period"
        case nextAt = "next-at"
    }
}

public extension Exoscale.KMSKey {
    struct RotationConfig: Codable, Hashable, Sendable {
        public let manualCount: Int?
        public let automatic: Bool?
        public let rotationPeriod: Int?
        public let nextAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            manualCount: Int? = nil,
            automatic: Bool? = nil,
            rotationPeriod: Int? = nil,
            nextAt: Date? = nil
        ) {
            self.manualCount = manualCount
            self.automatic = automatic
            self.rotationPeriod = rotationPeriod
            self.nextAt = nextAt
        }
    }
}

extension Exoscale.KMSKey.Material {
    enum CodingKeys: String, CodingKey {
        case version
        case createdAt = "created-at"
        case automatic
    }
}

public extension Exoscale.KMSKey {
    struct Material: Codable, Hashable, Sendable {
        public let version: Int?
        public let createdAt: Date?
        public let automatic: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            version: Int? = nil,
            createdAt: Date? = nil,
            automatic: Bool? = nil
        ) {
            self.version = version
            self.createdAt = createdAt
            self.automatic = automatic
        }
    }
}

extension Exoscale.KMSKey.ReplicaFailure {
    enum CodingKeys: String, CodingKey {
        case attemptedWatermark = "attempted-watermark"
        case error
        case failedAt = "failed-at"
    }
}

public extension Exoscale.KMSKey {
    struct ReplicaFailure: Codable, Hashable, Sendable {
        public let attemptedWatermark: Int?
        public let error: String?
        public let failedAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            attemptedWatermark: Int? = nil,
            error: String? = nil,
            failedAt: Date? = nil
        ) {
            self.attemptedWatermark = attemptedWatermark
            self.error = error
            self.failedAt = failedAt
        }
    }
}

extension Exoscale.KMSKey.ReplicaState {
    enum CodingKeys: String, CodingKey {
        case zone
        case lastAppliedWatermark = "last-applied-watermark"
        case lastFailure = "last-failure"
    }
}

public extension Exoscale.KMSKey {
    struct ReplicaState: Codable, Hashable, Sendable {
        public let zone: String?
        public let lastAppliedWatermark: Int?
        public let lastFailure: ReplicaFailure?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            zone: String? = nil,
            lastAppliedWatermark: Int? = nil,
            lastFailure: ReplicaFailure? = nil
        ) {
            self.zone = zone
            self.lastAppliedWatermark = lastAppliedWatermark
            self.lastFailure = lastFailure
        }
    }
}

extension Exoscale.KMSKey.Rotation {
    enum CodingKeys: String, CodingKey {
        case version
        case rotatedAt = "rotated-at"
        case automatic
    }
}

public extension Exoscale.KMSKey {
    struct Rotation: Codable, Hashable, Sendable {
        public let version: Int?
        public let rotatedAt: Date?
        public let automatic: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            version: Int? = nil,
            rotatedAt: Date? = nil,
            automatic: Bool? = nil
        ) {
            self.version = version
            self.rotatedAt = rotatedAt
            self.automatic = automatic
        }
    }
}
