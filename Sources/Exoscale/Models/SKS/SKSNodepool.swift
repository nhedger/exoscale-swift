public extension Exoscale {
    /// SKS nodepool returned by the API.
    struct SKSNodepool: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?

            public init(id: String? = nil) {
                self.id = id
            }
        }

        public struct Taint: Codable, Sendable {
            public enum Effect: String, Codable, Sendable {
                case noExecute = "NoExecute"
                case noSchedule = "NoSchedule"
                case preferNoSchedule = "PreferNoSchedule"
            }

            public let value: String?
            public let effect: Effect?

            public init(value: String? = nil, effect: Effect? = nil) {
                self.value = value
                self.effect = effect
            }
        }

        public struct KubeletImageGC: Codable, Sendable {
            public let highThreshold: Int?
            public let lowThreshold: Int?
            public let minAge: String?

            public init(
                highThreshold: Int? = nil,
                lowThreshold: Int? = nil,
                minAge: String? = nil
            ) {
                self.highThreshold = highThreshold
                self.lowThreshold = lowThreshold
                self.minAge = minAge
            }

            enum CodingKeys: String, CodingKey {
                case highThreshold = "high-threshold"
                case lowThreshold = "low-threshold"
                case minAge = "min-age"
            }
        }

        public enum PublicIPAssignment: String, Codable, Sendable {
            case inet4
            case dual
        }

        public enum State: String, Codable, Sendable {
            case renewingToken = "renewing-token"
            case creating
            case deleting
            case running
            case scaling
            case updating
            case error
        }

        public enum Addon: String, Codable, Sendable {
            case storageLVM = "storage-lvm"
        }

        public let antiAffinityGroups: [Reference]?
        public let description: String?
        public let publicIPAssignment: PublicIPAssignment?
        public let labels: [String: String]?
        public let taints: [String: Taint]?
        public let securityGroups: [Reference]?
        public let name: String?
        public let instanceType: Reference?
        public let privateNetworks: [Reference]?
        public let template: Reference?
        public let state: State?
        public let size: Int?
        public let kubeletImageGC: KubeletImageGC?
        public let instancePool: Reference?
        public let instancePrefix: String?
        public let deployTarget: Reference?
        public let addons: [Addon]?
        public let id: String?
        public let diskSize: Int?
        public let version: String?
        public let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case antiAffinityGroups = "anti-affinity-groups"
            case description
            case publicIPAssignment = "public-ip-assignment"
            case labels
            case taints
            case securityGroups = "security-groups"
            case name
            case instanceType = "instance-type"
            case privateNetworks = "private-networks"
            case template
            case state
            case size
            case kubeletImageGC = "kubelet-image-gc"
            case instancePool = "instance-pool"
            case instancePrefix = "instance-prefix"
            case deployTarget = "deploy-target"
            case addons
            case id
            case diskSize = "disk-size"
            case version
            case createdAt = "created-at"
        }
    }
}
