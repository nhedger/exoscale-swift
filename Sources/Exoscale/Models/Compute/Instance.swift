public extension Exoscale {
    /// Compute instance returned by the API.
    struct Instance: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?

            public init(id: String? = nil) {
                self.id = id
            }
        }

        public struct AntiAffinityGroupReference: Codable, Sendable {
            public let id: String?
        }

        public struct SecurityGroupReference: Codable, Sendable {
            public let id: String?
        }

        public struct ElasticIPReference: Codable, Sendable {
            public let id: String?
        }

        public struct SnapshotReference: Codable, Sendable {
            public let id: String?
        }

        public struct DeployTargetReference: Codable, Sendable {
            public let id: String?
        }

        public struct PrivateNetwork: Codable, Sendable {
            public let id: String?
            public let macAddress: String?

            enum CodingKeys: String, CodingKey {
                case id
                case macAddress = "mac-address"
            }
        }

        public enum PublicIPAssignment: String, Codable, Sendable {
            case inet4
            case dual
            case none
        }

        public enum State: String, Codable, Sendable {
            case expunging
            case starting
            case destroying
            case running
            case stopping
            case stopped
            case migrating
            case error
            case destroyed
        }

        public enum RescueProfile: String, Codable, Sendable {
            case netbootEFI = "netboot-efi"
            case netboot
        }

        public let applicationConsistentSnapshotEnabled: Bool?
        public let antiAffinityGroups: [AntiAffinityGroupReference]?
        public let publicIpAssignment: PublicIPAssignment?
        public let labels: [String: String]?
        public let securityGroups: [SecurityGroupReference]?
        public let elasticIPs: [ElasticIPReference]?
        public let id: String
        public let name: String
        public let instanceType: Exoscale.InstanceType?
        public let privateNetworks: [PrivateNetwork]?
        public let template: Exoscale.Template?
        public let state: State?
        public let secureBootEnabled: Bool?
        public let sshKey: Exoscale.SSHKey?
        public let userData: String?
        public let publicIp: String?
        public let ipv6Address: String?
        public let macAddress: String?
        public let manager: Exoscale.Manager?
        public let tpmEnabled: Bool?
        public let deployTarget: DeployTargetReference?
        public let snapshots: [SnapshotReference]?
        public let diskSize: Int?
        public let sshKeys: [Exoscale.SSHKey]?
        public let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
            case antiAffinityGroups = "anti-affinity-groups"
            case publicIpAssignment = "public-ip-assignment"
            case labels
            case securityGroups = "security-groups"
            case elasticIPs = "elastic-ips"
            case id
            case name
            case instanceType = "instance-type"
            case privateNetworks = "private-networks"
            case template
            case state
            case secureBootEnabled = "secureboot-enabled"
            case sshKey = "ssh-key"
            case userData = "user-data"
            case publicIp = "public-ip"
            case ipv6Address = "ipv6-address"
            case macAddress = "mac-address"
            case manager
            case tpmEnabled = "tpm-enabled"
            case deployTarget = "deploy-target"
            case snapshots
            case diskSize = "disk-size"
            case sshKeys = "ssh-keys"
            case createdAt = "created-at"
        }
    }
}
