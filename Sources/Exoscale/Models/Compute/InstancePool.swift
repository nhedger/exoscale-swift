public extension Exoscale {
    /// Instance Pool returned by the API.
    struct InstancePool: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?

            public init(id: String? = nil) {
                self.id = id
            }
        }

        public struct SSHKeyReference: Codable, Sendable {
            public let name: String?

            public init(name: String? = nil) {
                self.name = name
            }
        }

        public enum PublicIPAssignment: String, Codable, Sendable {
            case inet4
            case dual
            case none
        }

        public enum State: String, Codable, Sendable {
            case scalingUp = "scaling-up"
            case scalingDown = "scaling-down"
            case destroying
            case creating
            case suspended
            case running
            case updating
        }

        public let applicationConsistentSnapshotEnabled: Bool?
        public let antiAffinityGroups: [Reference]?
        public let description: String?
        public let publicIPAssignment: PublicIPAssignment?
        public let labels: [String: String]?
        public let securityGroups: [Reference]?
        public let elasticIPs: [Reference]?
        public let name: String?
        public let instanceType: Reference?
        public let minAvailable: Int?
        public let privateNetworks: [Reference]?
        public let template: Reference?
        public let state: State?
        public let size: Int?
        public let sshKey: SSHKeyReference?
        public let instancePrefix: String?
        public let userData: String?
        public let manager: Exoscale.Manager?
        public let instances: [Reference]?
        public let deployTarget: Reference?
        public let ipv6Enabled: Bool?
        public let id: String?
        public let diskSize: Int?
        public let sshKeys: [SSHKeyReference]?

        enum CodingKeys: String, CodingKey {
            case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
            case antiAffinityGroups = "anti-affinity-groups"
            case description
            case publicIPAssignment = "public-ip-assignment"
            case labels
            case securityGroups = "security-groups"
            case elasticIPs = "elastic-ips"
            case name
            case instanceType = "instance-type"
            case minAvailable = "min-available"
            case privateNetworks = "private-networks"
            case template
            case state
            case size
            case sshKey = "ssh-key"
            case instancePrefix = "instance-prefix"
            case userData = "user-data"
            case manager
            case instances
            case deployTarget = "deploy-target"
            case ipv6Enabled = "ipv6-enabled"
            case id
            case diskSize = "disk-size"
            case sshKeys = "ssh-keys"
        }
    }
}
