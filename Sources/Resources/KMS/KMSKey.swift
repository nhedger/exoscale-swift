import Foundation

public extension Exoscale {
    /// A key held by the Key Management Service (KMS) or an external key store.
    struct KMSKey: Hashable, Codable, Sendable {
        /// The key's identifier.
        public let id: String
        /// The key's name.
        public let name: String?
        /// The key's description.
        public let description: String?
        /// What the key is used for.
        public let usage: Usage?
        /// The key's algorithm and, for asymmetric keys, its curve or modulus size.
        public let keySpec: KeySpec?
        /// Where the key material is held.
        public let source: Source?
        /// The external key backing the key, when it comes from an external key store.
        public let xks: ExternalKey?
        /// Whether the key is enabled, disabled or scheduled for deletion.
        public let status: Status?
        /// When the key entered its current status.
        public let statusSince: Date?
        /// Whether the key is replicated to other zones.
        public let multiZone: Bool?
        /// The zone the key was created in.
        public let originZone: String?
        /// The zones the key is replicated to.
        public let replicas: [String]?
        /// The replication status in each zone.
        public let replicasStatus: [ReplicaStatus]?
        /// How the key material is rotated.
        public let rotation: Rotation?
        /// The current key material.
        public let material: Material?
        /// The key's revision.
        public let revision: Revision?
        /// When the key is deleted, if a deletion is scheduled.
        public let deleteAt: Date?
        /// When the key was created.
        public let createdAt: Date?

        /// Creates a key, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            usage: Usage? = nil,
            keySpec: KeySpec? = nil,
            source: Source? = nil,
            xks: ExternalKey? = nil,
            status: Status? = nil,
            statusSince: Date? = nil,
            multiZone: Bool? = nil,
            originZone: String? = nil,
            replicas: [String]? = nil,
            replicasStatus: [ReplicaStatus]? = nil,
            rotation: Rotation? = nil,
            material: Material? = nil,
            revision: Revision? = nil,
            deleteAt: Date? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.usage = usage
            self.keySpec = keySpec
            self.source = source
            self.xks = xks
            self.status = status
            self.statusSince = statusSince
            self.multiZone = multiZone
            self.originZone = originZone
            self.replicas = replicas
            self.replicasStatus = replicasStatus
            self.rotation = rotation
            self.material = material
            self.revision = revision
            self.deleteAt = deleteAt
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, usage, source, xks, status, replicas, rotation, material, revision
            case keySpec = "key-spec"
            case statusSince = "status-since"
            case multiZone = "multi-zone"
            case originZone = "origin-zone"
            case replicasStatus = "replicas-status"
            case deleteAt = "delete-at"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.KMSKey {
    /// What a key is used for.
    struct Usage: RawRepresentable, Hashable, Codable, Sendable {
        /// The usage as the API names it.
        public let rawValue: String

        /// Creates a usage, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Encrypting and decrypting data.
        public static let encryptDecrypt = Usage(rawValue: "encrypt-decrypt")
        /// Signing and verifying messages.
        public static let signVerify = Usage(rawValue: "sign-verify")
    }

    /// A key's algorithm and, for asymmetric keys, its curve or modulus size.
    struct KeySpec: RawRepresentable, Hashable, Codable, Sendable {
        /// The specification as the API names it.
        public let rawValue: String

        /// Creates a specification, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// 256-bit AES.
        public static let aes256 = KeySpec(rawValue: "AES_256")
        /// ECC on the NIST P-256 curve.
        public static let eccNISTP256 = KeySpec(rawValue: "ECC_NIST_P256")
        /// ECC on the NIST P-384 curve.
        public static let eccNISTP384 = KeySpec(rawValue: "ECC_NIST_P384")
        /// ECC on the NIST P-521 curve.
        public static let eccNISTP521 = KeySpec(rawValue: "ECC_NIST_P521")
        /// ECC on the Edwards25519 curve.
        public static let eccEdwards25519 = KeySpec(rawValue: "ECC_EDWARDS25519")
        /// 3072-bit RSA.
        public static let rsa3072 = KeySpec(rawValue: "RSA_3072")
        /// 4096-bit RSA.
        public static let rsa4096 = KeySpec(rawValue: "RSA_4096")
        /// ML-DSA-65, a post-quantum signature scheme.
        public static let mlDSA65 = KeySpec(rawValue: "ML_DSA_65")
        /// ML-DSA-87, a post-quantum signature scheme.
        public static let mlDSA87 = KeySpec(rawValue: "ML_DSA_87")
    }

    /// Where a key's material is held.
    struct Source: RawRepresentable, Hashable, Codable, Sendable {
        /// The source as the API names it.
        public let rawValue: String

        /// Creates a source, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Generated and held by Exoscale KMS.
        public static let exoscaleKMS = Source(rawValue: "exoscale-kms")
        /// Held in an external key store.
        public static let externalKeyStore = Source(rawValue: "external-key-store")
    }

    /// The status of a key.
    struct Status: RawRepresentable, Hashable, Codable, Sendable {
        /// The status as the API names it.
        public let rawValue: String

        /// Creates a status, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The key can be used.
        public static let enabled = Status(rawValue: "enabled")
        /// The key can't be used until it's enabled again.
        public static let disabled = Status(rawValue: "disabled")
        /// The key is scheduled for deletion.
        public static let pendingDeletion = Status(rawValue: "pending-deletion")
    }

    /// The external key backing a key from an external key store.
    struct ExternalKey: Hashable, Codable, Sendable {
        /// The key's identifier in the external key store.
        public let externalKeyID: String
        /// The external key store's identifier.
        public let xksID: String

        /// Creates an external key reference.
        public init(externalKeyID: String, xksID: String) {
            self.externalKeyID = externalKeyID
            self.xksID = xksID
        }

        enum CodingKeys: String, CodingKey {
            case externalKeyID = "external-key-id"
            case xksID = "xks-id"
        }
    }

    /// How a key's material is rotated.
    struct Rotation: Hashable, Codable, Sendable {
        /// Whether the material is rotated automatically.
        public let automatic: Bool?
        /// The number of days between automatic rotations.
        public let rotationPeriod: Int?
        /// When the next automatic rotation happens.
        public let nextAt: Date?
        /// The number of manual rotations over the key's life.
        public let manualCount: Int?

        /// Creates a rotation configuration, for example for previews and tests.
        public init(automatic: Bool? = nil, rotationPeriod: Int? = nil, nextAt: Date? = nil, manualCount: Int? = nil) {
            self.automatic = automatic
            self.rotationPeriod = rotationPeriod
            self.nextAt = nextAt
            self.manualCount = manualCount
        }

        enum CodingKeys: String, CodingKey {
            case automatic
            case rotationPeriod = "rotation-period"
            case nextAt = "next-at"
            case manualCount = "manual-count"
        }
    }

    /// A version of a key's material.
    struct Material: Hashable, Codable, Sendable {
        /// The material's version.
        public let version: Int?
        /// Whether it came from an automatic rotation.
        public let automatic: Bool?
        /// When it was created.
        public let createdAt: Date?

        /// Creates a material version, for example for previews and tests.
        public init(version: Int? = nil, automatic: Bool? = nil, createdAt: Date? = nil) {
            self.version = version
            self.automatic = automatic
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case version, automatic
            case createdAt = "created-at"
        }
    }

    /// A past rotation of a key's material.
    struct RotationRecord: Hashable, Codable, Sendable {
        /// The material version the rotation created.
        public let version: Int?
        /// Whether the rotation was automatic.
        public let automatic: Bool?
        /// When the rotation happened.
        public let rotatedAt: Date?

        /// Creates a rotation record, for example for previews and tests.
        public init(version: Int? = nil, automatic: Bool? = nil, rotatedAt: Date? = nil) {
            self.version = version
            self.automatic = automatic
            self.rotatedAt = rotatedAt
        }

        enum CodingKeys: String, CodingKey {
            case version, automatic
            case rotatedAt = "rotated-at"
        }
    }

    /// A key's revision.
    struct Revision: Hashable, Codable, Sendable {
        /// The revision's sequence number.
        public let seq: Int?
        /// When the revision was made.
        public let at: Date?

        /// Creates a revision, for example for previews and tests.
        public init(seq: Int? = nil, at: Date? = nil) {
            self.seq = seq
            self.at = at
        }
    }

    /// The replication status of a key in one zone.
    struct ReplicaStatus: Hashable, Codable, Sendable {
        /// The zone.
        public let zone: String?
        /// The latest change applied in the zone.
        public let lastAppliedWatermark: Int?
        /// The latest failure to apply a change, if any.
        public let lastFailure: Failure?

        /// Creates a replica status, for example for previews and tests.
        public init(zone: String? = nil, lastAppliedWatermark: Int? = nil, lastFailure: Failure? = nil) {
            self.zone = zone
            self.lastAppliedWatermark = lastAppliedWatermark
            self.lastFailure = lastFailure
        }

        enum CodingKeys: String, CodingKey {
            case zone
            case lastAppliedWatermark = "last-applied-watermark"
            case lastFailure = "last-failure"
        }

        /// A failure to apply a change in a zone.
        public struct Failure: Hashable, Codable, Sendable {
            /// The change that failed.
            public let attemptedWatermark: Int?
            /// What went wrong.
            public let error: String?
            /// When it failed.
            public let failedAt: Date?

            /// Creates a failure, for example for previews and tests.
            public init(attemptedWatermark: Int? = nil, error: String? = nil, failedAt: Date? = nil) {
                self.attemptedWatermark = attemptedWatermark
                self.error = error
                self.failedAt = failedAt
            }

            enum CodingKeys: String, CodingKey {
                case error
                case attemptedWatermark = "attempted-watermark"
                case failedAt = "failed-at"
            }
        }
    }
}
