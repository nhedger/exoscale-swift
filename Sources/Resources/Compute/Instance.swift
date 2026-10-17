import Foundation

public extension Exoscale {
    /// A compute instance.
    ///
    /// Instances from ``Instances/list(instancePoolID:ipAddress:labels:)`` include fewer fields
    /// than those from ``Instances/get(id:)``.
    struct Instance: Hashable, Codable, Sendable {
        /// The instance's identifier.
        public let id: String
        /// The instance's name.
        public let name: String?
        /// Whether the instance is running, stopped or changing state.
        public let state: State?
        /// When the instance was created.
        public let createdAt: Date?
        /// The instance's type, which sets its CPU and memory.
        public let instanceType: Reference<InstanceType>?
        /// The template the instance was created from.
        public let template: Reference<Template>?
        /// The size of the root disk, in GiB.
        public let diskSize: Int?
        /// Whether the root disk is encrypted.
        public let diskEncrypted: Bool?
        /// The labels attached to the instance.
        public let labels: [String: String]?
        /// The public IPv4 address.
        public let publicIP: String?
        /// The public IPv6 address, when IPv6 is enabled.
        public let ipv6Address: String?
        /// Which public addresses the instance has.
        public let publicIPAssignment: PublicIPAssignment?
        /// The MAC address of the public network interface.
        public let macAddress: String?
        /// The security groups the instance belongs to.
        public let securityGroups: [Reference<SecurityGroup>]?
        /// The anti-affinity groups the instance belongs to.
        public let antiAffinityGroups: [Reference<AntiAffinityGroup>]?
        /// The Elastic IPs attached to the instance.
        public let elasticIPs: [Reference<ElasticIP>]?
        /// The private networks the instance is attached to.
        public let privateNetworks: [PrivateNetworkAttachment]?
        /// The VPC subnets the instance is attached to.
        public let vpc: VPCAttachment?
        /// Whether the instance may forward traffic for other addresses in its VPC.
        public let ipForwarding: Bool?
        /// The SSH keys installed when the instance was created.
        public let sshKeys: [Reference<SSHKey>]?
        /// The base64-encoded cloud-init user data.
        public let userData: String?
        /// The instance pool or SKS node pool managing the instance.
        public let manager: Manager?
        /// The dedicated hypervisor the instance runs on.
        public let deployTarget: Reference<DeployTarget>?
        /// The instance's snapshots.
        public let snapshots: [Reference<Snapshot>]?
        /// Whether secure boot is enabled.
        public let secureBootEnabled: Bool?
        /// Whether the instance has a Trusted Platform Module.
        public let tpmEnabled: Bool?
        /// Whether snapshots ask the guest to flush its file systems first.
        public let applicationConsistentSnapshotEnabled: Bool?

        /// Creates an instance, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            createdAt: Date? = nil,
            instanceType: Reference<InstanceType>? = nil,
            template: Reference<Template>? = nil,
            diskSize: Int? = nil,
            diskEncrypted: Bool? = nil,
            labels: [String: String]? = nil,
            publicIP: String? = nil,
            ipv6Address: String? = nil,
            publicIPAssignment: PublicIPAssignment? = nil,
            macAddress: String? = nil,
            securityGroups: [Reference<SecurityGroup>]? = nil,
            antiAffinityGroups: [Reference<AntiAffinityGroup>]? = nil,
            elasticIPs: [Reference<ElasticIP>]? = nil,
            privateNetworks: [PrivateNetworkAttachment]? = nil,
            vpc: VPCAttachment? = nil,
            ipForwarding: Bool? = nil,
            sshKeys: [Reference<SSHKey>]? = nil,
            userData: String? = nil,
            manager: Manager? = nil,
            deployTarget: Reference<DeployTarget>? = nil,
            snapshots: [Reference<Snapshot>]? = nil,
            secureBootEnabled: Bool? = nil,
            tpmEnabled: Bool? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.createdAt = createdAt
            self.instanceType = instanceType
            self.template = template
            self.diskSize = diskSize
            self.diskEncrypted = diskEncrypted
            self.labels = labels
            self.publicIP = publicIP
            self.ipv6Address = ipv6Address
            self.publicIPAssignment = publicIPAssignment
            self.macAddress = macAddress
            self.securityGroups = securityGroups
            self.antiAffinityGroups = antiAffinityGroups
            self.elasticIPs = elasticIPs
            self.privateNetworks = privateNetworks
            self.vpc = vpc
            self.ipForwarding = ipForwarding
            self.sshKeys = sshKeys
            self.userData = userData
            self.manager = manager
            self.deployTarget = deployTarget
            self.snapshots = snapshots
            self.secureBootEnabled = secureBootEnabled
            self.tpmEnabled = tpmEnabled
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, template, labels, manager, snapshots, vpc
            case createdAt = "created-at"
            case instanceType = "instance-type"
            case diskSize = "disk-size"
            case diskEncrypted = "disk-encrypted"
            case publicIP = "public-ip"
            case ipv6Address = "ipv6-address"
            case publicIPAssignment = "public-ip-assignment"
            case macAddress = "mac-address"
            case securityGroups = "security-groups"
            case antiAffinityGroups = "anti-affinity-groups"
            case elasticIPs = "elastic-ips"
            case privateNetworks = "private-networks"
            case ipForwarding = "ip-forwarding"
            case sshKeys = "ssh-keys"
            case userData = "user-data"
            case deployTarget = "deploy-target"
            case secureBootEnabled = "secureboot-enabled"
            case tpmEnabled = "tpm-enabled"
            case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        }
    }
}

public extension Exoscale.Instance {
    /// The state of an instance.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The instance is starting.
        public static let starting = State(rawValue: "starting")
        /// The instance is running.
        public static let running = State(rawValue: "running")
        /// The instance is stopping.
        public static let stopping = State(rawValue: "stopping")
        /// The instance is stopped.
        public static let stopped = State(rawValue: "stopped")
        /// The instance is moving to another hypervisor.
        public static let migrating = State(rawValue: "migrating")
        /// The instance is being deleted.
        public static let destroying = State(rawValue: "destroying")
        /// The instance has been deleted.
        public static let destroyed = State(rawValue: "destroyed")
        /// The instance's storage is being removed after deletion.
        public static let expunging = State(rawValue: "expunging")
        /// The instance is in an error state.
        public static let error = State(rawValue: "error")
    }

    /// Which public IP addresses an instance has.
    struct PublicIPAssignment: RawRepresentable, Hashable, Codable, Sendable {
        /// The assignment as the API names it.
        public let rawValue: String

        /// Creates an assignment, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// A public IPv4 address only.
        public static let ipv4 = PublicIPAssignment(rawValue: "inet4")
        /// Public IPv4 and IPv6 addresses.
        public static let dual = PublicIPAssignment(rawValue: "dual")
        /// No public address.
        public static let none = PublicIPAssignment(rawValue: "none")
    }

    /// The profile a rescue boot uses.
    struct RescueProfile: RawRepresentable, Hashable, Codable, Sendable {
        /// The profile as the API names it.
        public let rawValue: String

        /// Creates a profile, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Network boot with BIOS.
        public static let netboot = RescueProfile(rawValue: "netboot")
        /// Network boot with UEFI.
        public static let netbootEFI = RescueProfile(rawValue: "netboot-efi")
    }

    /// An instance's attachment to a private network.
    struct PrivateNetworkAttachment: Hashable, Codable, Sendable {
        /// The private network's identifier.
        public let id: String?
        /// The MAC address of the instance's interface on that network.
        public let macAddress: String?

        /// Creates an attachment, for example for previews and tests.
        public init(id: String? = nil, macAddress: String? = nil) {
            self.id = id
            self.macAddress = macAddress
        }

        enum CodingKeys: String, CodingKey {
            case id
            case macAddress = "mac-address"
        }
    }

    /// An instance's attachment to subnets of a VPC.
    struct VPCAttachment: Hashable, Codable, Sendable {
        /// The VPC's identifier.
        public let id: String
        /// The VPC's name, in responses.
        public let name: String?
        /// The subnets the instance is attached to.
        public let subnets: [Subnet]

        /// Creates an attachment, for example to create an instance in a VPC.
        public init(id: String, name: String? = nil, subnets: [Subnet]) {
            self.id = id
            self.name = name
            self.subnets = subnets
        }

        /// A subnet an instance is attached to.
        public struct Subnet: Hashable, Codable, Sendable {
            /// The subnet's identifier.
            public let id: String
            /// The subnet's name, in responses.
            public let name: String?
            /// The instance's IPv4 address in the subnet. When creating an instance, `nil` picks
            /// a random one.
            public let ipv4: String?

            /// Creates a subnet attachment.
            public init(id: String, name: String? = nil, ipv4: String? = nil) {
                self.id = id
                self.name = name
                self.ipv4 = ipv4
            }
        }
    }

    /// The instance pool or SKS node pool managing an instance.
    struct Manager: Hashable, Codable, Sendable {
        /// The manager's identifier.
        public let id: String?
        /// Whether the manager is an instance pool or an SKS node pool.
        public let type: Kind?

        /// Creates a manager, for example for previews and tests.
        public init(id: String? = nil, type: Kind? = nil) {
            self.id = id
            self.type = type
        }

        /// The kind of manager.
        public struct Kind: RawRepresentable, Hashable, Codable, Sendable {
            /// The kind as the API names it.
            public let rawValue: String

            /// Creates a kind, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// An instance pool.
            public static let instancePool = Kind(rawValue: "instance-pool")
            /// An SKS node pool.
            public static let sksNodepool = Kind(rawValue: "sks-nodepool")
        }
    }
}
