public extension Exoscale {
    /// KMS key returned by the API.
    struct KMSKey: Codable, Sendable {
        public enum Usage: String, Codable, Sendable {
            case encryptDecrypt = "encrypt-decrypt"
        }

        public enum Source: String, Codable, Sendable {
            case exoscaleKMS = "exoscale-kms"
        }

        public enum Status: String, Codable, Sendable {
            case enabled
            case disabled
            case pendingDeletion = "pending-deletion"
        }

        public enum ActionStatus: String, Codable, Sendable {
            case success
            case targetRegistered = "target-registered"
        }

        public struct Revision: Codable, Sendable {
            public let at: String?
            public let seq: Int?
        }

        public struct RotationConfig: Codable, Sendable {
            public let manualCount: Int?
            public let automatic: Bool?
            public let rotationPeriod: Int?
            public let nextAt: String?

            enum CodingKeys: String, CodingKey {
                case manualCount = "manual-count"
                case automatic
                case rotationPeriod = "rotation-period"
                case nextAt = "next-at"
            }
        }

        public struct Material: Codable, Sendable {
            public let version: Int?
            public let createdAt: String?
            public let automatic: Bool?

            enum CodingKeys: String, CodingKey {
                case version
                case createdAt = "created-at"
                case automatic
            }
        }

        public struct ReplicaFailure: Codable, Sendable {
            public let attemptedWatermark: Int?
            public let error: String?
            public let failedAt: String?

            enum CodingKeys: String, CodingKey {
                case attemptedWatermark = "attempted-watermark"
                case error
                case failedAt = "failed-at"
            }
        }

        public struct ReplicaState: Codable, Sendable {
            public let zone: String?
            public let lastAppliedWatermark: Int?
            public let lastFailure: ReplicaFailure?

            enum CodingKeys: String, CodingKey {
                case zone
                case lastAppliedWatermark = "last-applied-watermark"
                case lastFailure = "last-failure"
            }
        }

        public struct Rotation: Codable, Sendable {
            public let version: Int?
            public let rotatedAt: String?
            public let automatic: Bool?

            enum CodingKeys: String, CodingKey {
                case version
                case rotatedAt = "rotated-at"
                case automatic
            }
        }

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
        public let statusSince: String?
        public let id: String?
        public let replicas: [String]?
        public let material: Material?
        public let originZone: String?
        public let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case zone
            case description
            case rotation
            case revision
            case name
            case multiZone = "multi-zone"
            case source
            case usage
            case replicasStatus = "replicas-status"
            case status
            case statusSince = "status-since"
            case id
            case replicas
            case material
            case originZone = "origin-zone"
            case createdAt = "created-at"
        }
    }
}
