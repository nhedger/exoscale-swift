import Foundation

public extension Exoscale {
    /// Compute instance returned by the API.
    struct Instance: Hashable, Identifiable, Sendable {
        public let applicationConsistentSnapshotEnabled: Bool?
        public let antiAffinityGroups: [Exoscale.Reference<Exoscale.AntiAffinityGroup>]?
        public let publicIpAssignment: PublicIPAssignment?
        public let labels: [String: String]?
        public let securityGroups: [Exoscale.Reference<Exoscale.SecurityGroup>]?
        public let elasticIPs: [Exoscale.Reference<Exoscale.ElasticIP>]?
        public let id: String
        public let name: String
        public let instanceType: Exoscale.Reference<Exoscale.InstanceType>?
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
        public let deployTarget: Exoscale.Reference<Exoscale.DeployTarget>?
        public let snapshots: [Exoscale.Reference<Exoscale.Snapshot>]?
        public let diskSize: Int?
        public let diskEncrypted: Bool?
        public let sshKeys: [Exoscale.SSHKey]?
        public let createdAt: Date?

        let client: Http.Client

        /// Creates a model bound to `client`, for example for previews and tests.
        public init(
            applicationConsistentSnapshotEnabled: Bool? = nil,
            antiAffinityGroups: [Exoscale.Reference<Exoscale.AntiAffinityGroup>]? = nil,
            publicIpAssignment: PublicIPAssignment? = nil,
            labels: [String: String]? = nil,
            securityGroups: [Exoscale.Reference<Exoscale.SecurityGroup>]? = nil,
            elasticIPs: [Exoscale.Reference<Exoscale.ElasticIP>]? = nil,
            id: String,
            name: String,
            instanceType: Exoscale.Reference<Exoscale.InstanceType>? = nil,
            privateNetworks: [PrivateNetwork]? = nil,
            template: Exoscale.Template? = nil,
            state: State? = nil,
            secureBootEnabled: Bool? = nil,
            sshKey: Exoscale.SSHKey? = nil,
            userData: String? = nil,
            publicIp: String? = nil,
            ipv6Address: String? = nil,
            macAddress: String? = nil,
            manager: Exoscale.Manager? = nil,
            tpmEnabled: Bool? = nil,
            deployTarget: Exoscale.Reference<Exoscale.DeployTarget>? = nil,
            snapshots: [Exoscale.Reference<Exoscale.Snapshot>]? = nil,
            diskSize: Int? = nil,
            diskEncrypted: Bool? = nil,
            sshKeys: [Exoscale.SSHKey]? = nil,
            createdAt: Date? = nil,
            client: Exoscale
        ) {
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
            self.antiAffinityGroups = antiAffinityGroups
            self.publicIpAssignment = publicIpAssignment
            self.labels = labels
            self.securityGroups = securityGroups
            self.elasticIPs = elasticIPs
            self.id = id
            self.name = name
            self.instanceType = instanceType
            self.privateNetworks = privateNetworks
            self.template = template
            self.state = state
            self.secureBootEnabled = secureBootEnabled
            self.sshKey = sshKey
            self.userData = userData
            self.publicIp = publicIp
            self.ipv6Address = ipv6Address
            self.macAddress = macAddress
            self.manager = manager
            self.tpmEnabled = tpmEnabled
            self.deployTarget = deployTarget
            self.snapshots = snapshots
            self.diskSize = diskSize
            self.diskEncrypted = diskEncrypted
            self.sshKeys = sshKeys
            self.createdAt = createdAt
            self.client = client.http
        }

        init(data: Payload, client: Http.Client) {
            applicationConsistentSnapshotEnabled = data.applicationConsistentSnapshotEnabled
            antiAffinityGroups = data.antiAffinityGroups?.compactMap { reference in
                reference.id.map { id in
                    Exoscale.Reference(id: id) { try await AntiAffinityGroupsResource(http: client).get(id: $0) }
                }
            }
            publicIpAssignment = data.publicIpAssignment
            labels = data.labels
            securityGroups = data.securityGroups?.compactMap { reference in
                reference.id.map { id in
                    Exoscale.Reference(id: id) { try await SecurityGroupsResource(http: client).get(id: $0) }
                }
            }
            elasticIPs = data.elasticIPs?.compactMap { reference in
                reference.id.map { id in
                    Exoscale.Reference(id: id) { try await ElasticIPsResource(http: client).get(id: $0) }
                }
            }
            id = data.id
            name = data.name
            instanceType = data.instanceType?.id.map { id in
                Exoscale.Reference(id: id) { try await InstanceTypesResource(http: client).get(id: $0) }
            }
            privateNetworks = data.privateNetworks
            template = data.template.map { Exoscale.Template(data: $0, client: client) }
            state = data.state
            secureBootEnabled = data.secureBootEnabled
            sshKey = data.sshKey.map { Exoscale.SSHKey(data: $0, client: client) }
            userData = data.userData
            publicIp = data.publicIp
            ipv6Address = data.ipv6Address
            macAddress = data.macAddress
            manager = data.manager.map { Exoscale.Manager(data: $0, client: client) }
            tpmEnabled = data.tpmEnabled
            deployTarget = data.deployTarget?.id.map { id in
                Exoscale.Reference(id: id) { try await DeployTargetsResource(http: client).get(id: $0) }
            }
            snapshots = data.snapshots?.compactMap { reference in
                reference.id.map { id in
                    Exoscale.Reference(id: id) { try await SnapshotsResource(http: client).get(id: $0) }
                }
            }
            diskSize = data.diskSize
            diskEncrypted = data.diskEncrypted
            sshKeys = data.sshKeys.map { $0.map { Exoscale.SSHKey(data: $0, client: client) } }
            createdAt = data.createdAt
            self.client = client
        }
    }
}

public extension Exoscale.Instance {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?

        public init(id: String? = nil) {
            self.id = id
        }
    }
}

public extension Exoscale.Instance {
    struct AntiAffinityGroupReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

public extension Exoscale.Instance {
    struct SecurityGroupReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

public extension Exoscale.Instance {
    struct ElasticIPReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

public extension Exoscale.Instance {
    struct SnapshotReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

public extension Exoscale.Instance {
    struct DeployTargetReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

extension Exoscale.Instance.PrivateNetwork {
    enum CodingKeys: String, CodingKey {
        case id
        case macAddress = "mac-address"
    }
}

public extension Exoscale.Instance {
    struct PrivateNetwork: Codable, Hashable, Sendable {
        public let id: String?
        public let macAddress: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            macAddress: String? = nil
        ) {
            self.id = id
            self.macAddress = macAddress
        }
    }
}

public extension Exoscale.Instance {
    enum PublicIPAssignment: Exoscale.ExtensibleEnum {
        case inet4
        case dual
        case none
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.inet4, .dual, .none]

        public var rawValue: String {
            switch self {
            case .inet4: "inet4"
            case .dual: "dual"
            case .none: "none"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.Instance {
    enum State: Exoscale.ExtensibleEnum {
        case expunging
        case starting
        case destroying
        case running
        case stopping
        case stopped
        case migrating
        case error
        case destroyed
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .expunging,
            .starting,
            .destroying,
            .running,
            .stopping,
            .stopped,
            .migrating,
            .error,
            .destroyed
        ]

        public var rawValue: String {
            switch self {
            case .expunging: "expunging"
            case .starting: "starting"
            case .destroying: "destroying"
            case .running: "running"
            case .stopping: "stopping"
            case .stopped: "stopped"
            case .migrating: "migrating"
            case .error: "error"
            case .destroyed: "destroyed"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.Instance {
    enum RescueProfile: Exoscale.ExtensibleEnum {
        case netbootEFI
        case netboot
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.netbootEFI, .netboot]

        public var rawValue: String {
            switch self {
            case .netbootEFI: "netboot-efi"
            case .netboot: "netboot"
            case let .unknown(value): value
            }
        }
    }
}
