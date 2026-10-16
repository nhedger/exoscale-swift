public extension Exoscale {
    /// Instance Pool returned by the API.
    struct InstancePool: Hashable, Sendable {
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

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            applicationConsistentSnapshotEnabled: Bool? = nil,
            antiAffinityGroups: [Reference]? = nil,
            description: String? = nil,
            publicIPAssignment: PublicIPAssignment? = nil,
            labels: [String: String]? = nil,
            securityGroups: [Reference]? = nil,
            elasticIPs: [Reference]? = nil,
            name: String? = nil,
            instanceType: Reference? = nil,
            minAvailable: Int? = nil,
            privateNetworks: [Reference]? = nil,
            template: Reference? = nil,
            state: State? = nil,
            size: Int? = nil,
            sshKey: SSHKeyReference? = nil,
            instancePrefix: String? = nil,
            userData: String? = nil,
            manager: Exoscale.Manager? = nil,
            instances: [Reference]? = nil,
            deployTarget: Reference? = nil,
            ipv6Enabled: Bool? = nil,
            id: String? = nil,
            diskSize: Int? = nil,
            sshKeys: [SSHKeyReference]? = nil
        ) {
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
            self.antiAffinityGroups = antiAffinityGroups
            self.description = description
            self.publicIPAssignment = publicIPAssignment
            self.labels = labels
            self.securityGroups = securityGroups
            self.elasticIPs = elasticIPs
            self.name = name
            self.instanceType = instanceType
            self.minAvailable = minAvailable
            self.privateNetworks = privateNetworks
            self.template = template
            self.state = state
            self.size = size
            self.sshKey = sshKey
            self.instancePrefix = instancePrefix
            self.userData = userData
            self.manager = manager
            self.instances = instances
            self.deployTarget = deployTarget
            self.ipv6Enabled = ipv6Enabled
            self.id = id
            self.diskSize = diskSize
            self.sshKeys = sshKeys
        }

        init(data: Payload, client: Http.Client) {
            applicationConsistentSnapshotEnabled = data.applicationConsistentSnapshotEnabled
            antiAffinityGroups = data.antiAffinityGroups
            description = data.description
            publicIPAssignment = data.publicIPAssignment
            labels = data.labels
            securityGroups = data.securityGroups
            elasticIPs = data.elasticIPs
            name = data.name
            instanceType = data.instanceType
            minAvailable = data.minAvailable
            privateNetworks = data.privateNetworks
            template = data.template
            state = data.state
            size = data.size
            sshKey = data.sshKey
            instancePrefix = data.instancePrefix
            userData = data.userData
            manager = data.manager.map { Exoscale.Manager(data: $0, client: client) }
            instances = data.instances
            deployTarget = data.deployTarget
            ipv6Enabled = data.ipv6Enabled
            id = data.id
            diskSize = data.diskSize
            sshKeys = data.sshKeys
        }
    }
}

public extension Exoscale.InstancePool {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?

        public init(id: String? = nil) {
            self.id = id
        }
    }
}

public extension Exoscale.InstancePool {
    struct SSHKeyReference: Codable, Hashable, Sendable {
        public let name: String?

        public init(name: String? = nil) {
            self.name = name
        }
    }
}

public extension Exoscale.InstancePool {
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

public extension Exoscale.InstancePool {
    enum State: Exoscale.ExtensibleEnum {
        case scalingUp
        case scalingDown
        case destroying
        case creating
        case suspended
        case running
        case updating
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .scalingUp,
            .scalingDown,
            .destroying,
            .creating,
            .suspended,
            .running,
            .updating
        ]

        public var rawValue: String {
            switch self {
            case .scalingUp: "scaling-up"
            case .scalingDown: "scaling-down"
            case .destroying: "destroying"
            case .creating: "creating"
            case .suspended: "suspended"
            case .running: "running"
            case .updating: "updating"
            case let .unknown(value): value
            }
        }
    }
}
