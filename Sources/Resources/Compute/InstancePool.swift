public extension Exoscale {
    /// A group of identical instances kept at a given size.
    struct InstancePool: Hashable, Codable, Sendable {
        /// The pool's identifier.
        public let id: String
        /// The pool's name.
        public let name: String?
        /// The pool's description.
        public let description: String?
        /// Whether the pool is running, scaling or in an error state.
        public let state: State?
        /// Why the pool is in an error state.
        public let errorReason: ErrorReason?
        /// The number of instances the pool keeps.
        public let size: Int?
        /// The minimum number of instances kept running while the pool is updated.
        public let minAvailable: Int?
        /// The instances in the pool.
        public let instances: [Reference<Instance>]?
        /// The prefix of the instances' names.
        public let instancePrefix: String?
        /// The SKS node pool managing this pool, if any.
        public let manager: Instance.Manager?
        /// The instance type of the pool's instances.
        public let instanceType: Reference<InstanceType>?
        /// The template the pool's instances are created from.
        public let template: Reference<Template>?
        /// The size of the instances' root disks, in GiB.
        public let diskSize: Int?
        /// The labels attached to the pool.
        public let labels: [String: String]?
        /// Which public addresses the instances get.
        public let publicIPAssignment: Instance.PublicIPAssignment?
        /// Whether the instances get a public IPv6 address.
        public let ipv6Enabled: Bool?
        /// The security groups the instances are in.
        public let securityGroups: [Reference<SecurityGroup>]?
        /// The anti-affinity groups the instances are in.
        public let antiAffinityGroups: [Reference<AntiAffinityGroup>]?
        /// The Elastic IPs attached to the instances.
        public let elasticIPs: [Reference<ElasticIP>]?
        /// The private networks the instances are attached to.
        public let privateNetworks: [Reference<PrivateNetwork>]?
        /// The SSH keys installed on the instances.
        public let sshKeys: [Reference<SSHKey>]?
        /// The base64-encoded cloud-init user data.
        public let userData: String?
        /// The dedicated hypervisor the instances run on.
        public let deployTarget: Reference<DeployTarget>?
        /// Whether snapshots ask the guest to flush its file systems first.
        public let applicationConsistentSnapshotEnabled: Bool?

        /// Creates an instance pool, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            state: State? = nil,
            errorReason: ErrorReason? = nil,
            size: Int? = nil,
            minAvailable: Int? = nil,
            instances: [Reference<Instance>]? = nil,
            instancePrefix: String? = nil,
            manager: Instance.Manager? = nil,
            instanceType: Reference<InstanceType>? = nil,
            template: Reference<Template>? = nil,
            diskSize: Int? = nil,
            labels: [String: String]? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            ipv6Enabled: Bool? = nil,
            securityGroups: [Reference<SecurityGroup>]? = nil,
            antiAffinityGroups: [Reference<AntiAffinityGroup>]? = nil,
            elasticIPs: [Reference<ElasticIP>]? = nil,
            privateNetworks: [Reference<PrivateNetwork>]? = nil,
            sshKeys: [Reference<SSHKey>]? = nil,
            userData: String? = nil,
            deployTarget: Reference<DeployTarget>? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.state = state
            self.errorReason = errorReason
            self.size = size
            self.minAvailable = minAvailable
            self.instances = instances
            self.instancePrefix = instancePrefix
            self.manager = manager
            self.instanceType = instanceType
            self.template = template
            self.diskSize = diskSize
            self.labels = labels
            self.publicIPAssignment = publicIPAssignment
            self.ipv6Enabled = ipv6Enabled
            self.securityGroups = securityGroups
            self.antiAffinityGroups = antiAffinityGroups
            self.elasticIPs = elasticIPs
            self.privateNetworks = privateNetworks
            self.sshKeys = sshKeys
            self.userData = userData
            self.deployTarget = deployTarget
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, state, size, instances, manager, template, labels
            case errorReason = "error-reason"
            case minAvailable = "min-available"
            case instancePrefix = "instance-prefix"
            case instanceType = "instance-type"
            case diskSize = "disk-size"
            case publicIPAssignment = "public-ip-assignment"
            case ipv6Enabled = "ipv6-enabled"
            case securityGroups = "security-groups"
            case antiAffinityGroups = "anti-affinity-groups"
            case elasticIPs = "elastic-ips"
            case privateNetworks = "private-networks"
            case sshKeys = "ssh-keys"
            case userData = "user-data"
            case deployTarget = "deploy-target"
            case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        }
    }
}

public extension Exoscale.InstancePool {
    /// The state of an instance pool.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The pool is being created.
        public static let creating = State(rawValue: "creating")
        /// The pool is at its size.
        public static let running = State(rawValue: "running")
        /// Instances are being added.
        public static let scalingUp = State(rawValue: "scaling-up")
        /// Instances are being removed.
        public static let scalingDown = State(rawValue: "scaling-down")
        /// The pool's settings are being applied.
        public static let updating = State(rawValue: "updating")
        /// The pool is suspended.
        public static let suspended = State(rawValue: "suspended")
        /// The pool is being deleted.
        public static let destroying = State(rawValue: "destroying")
        /// The pool is in an error state; see ``Exoscale/InstancePool/errorReason``.
        public static let error = State(rawValue: "error")
    }

    /// Why an instance pool is in an error state.
    struct ErrorReason: Hashable, Codable, Sendable {
        /// What caused the error.
        public let cause: String?
        /// The kind of error.
        public let type: String?
        /// The identifier of the job that failed.
        public let jobID: String?

        /// Creates an error reason, for example for previews and tests.
        public init(cause: String? = nil, type: String? = nil, jobID: String? = nil) {
            self.cause = cause
            self.type = type
            self.jobID = jobID
        }

        enum CodingKeys: String, CodingKey {
            case cause, type
            case jobID = "job-id"
        }
    }

    /// A setting of an instance pool that can be reset to its default.
    struct Field: RawRepresentable, Hashable, Sendable {
        /// The field as the API names it.
        public let rawValue: String

        /// Creates a field, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The anti-affinity groups.
        public static let antiAffinityGroups = Field(rawValue: "anti-affinity-groups")
        /// The deploy target.
        public static let deployTarget = Field(rawValue: "deploy-target")
        /// The description.
        public static let description = Field(rawValue: "description")
        /// The Elastic IPs.
        public static let elasticIPs = Field(rawValue: "elastic-ips")
        /// Whether instances get a public IPv6 address.
        public static let ipv6Enabled = Field(rawValue: "ipv6-enabled")
        /// The labels.
        public static let labels = Field(rawValue: "labels")
        /// The private networks.
        public static let privateNetworks = Field(rawValue: "private-networks")
        /// The security groups.
        public static let securityGroups = Field(rawValue: "security-groups")
        /// The SSH key.
        public static let sshKey = Field(rawValue: "ssh-key")
        /// The cloud-init user data.
        public static let userData = Field(rawValue: "user-data")
    }
}
