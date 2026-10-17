import Foundation

public extension Exoscale {
    /// A pool of identical worker nodes in an SKS cluster.
    struct SKSNodepool: Hashable, Codable, Sendable {
        /// The node pool's identifier.
        public let id: String
        /// The node pool's name.
        public let name: String?
        /// The node pool's description.
        public let description: String?
        /// Whether the node pool is running or changing state.
        public let state: State?
        /// The number of nodes.
        public let size: Int?
        /// The Kubernetes version of the nodes.
        public let version: String?
        /// The instance type of the nodes.
        public let instanceType: Reference<InstanceType>?
        /// The template the nodes are created from.
        public let template: Reference<Template>?
        /// The size of the nodes' root disks, in GiB.
        public let diskSize: Int?
        /// The prefix of the nodes' names.
        public let instancePrefix: String?
        /// The instance pool running the nodes.
        public let instancePool: Reference<InstancePool>?
        /// The dedicated hypervisor the nodes run on.
        public let deployTarget: Reference<DeployTarget>?
        /// Which public addresses the nodes get.
        public let publicIPAssignment: Instance.PublicIPAssignment?
        /// The Kubernetes labels applied to the nodes.
        public let labels: [String: String]?
        /// The Kubernetes taints applied to the nodes, keyed by taint key.
        public let taints: [String: Taint]?
        /// The security groups the nodes are in.
        public let securityGroups: [Reference<SecurityGroup>]?
        /// The anti-affinity groups the nodes are in.
        public let antiAffinityGroups: [Reference<AntiAffinityGroup>]?
        /// The private networks the nodes are attached to.
        public let privateNetworks: [Reference<PrivateNetwork>]?
        /// The node pool's add-ons.
        public let addons: [Addon]?
        /// When the kubelet removes unused images.
        public let kubeletImageGC: KubeletImageGC?
        /// The maximum number of pods per node, when not the kubelet's default.
        public let kubeletMaxPods: Int?
        /// How the kubelet assigns CPUs to pods.
        public let cpuManagerConfig: CPUManagerConfig?
        /// The NVIDIA Multi-Instance GPU profile of each GPU model, keyed by model such as `a30.24gb`.
        public let nvidiaMIGProfiles: [String: String]?
        /// When the node pool was created.
        public let createdAt: Date?

        /// Creates a node pool, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            state: State? = nil,
            size: Int? = nil,
            version: String? = nil,
            instanceType: Reference<InstanceType>? = nil,
            template: Reference<Template>? = nil,
            diskSize: Int? = nil,
            instancePrefix: String? = nil,
            instancePool: Reference<InstancePool>? = nil,
            deployTarget: Reference<DeployTarget>? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            labels: [String: String]? = nil,
            taints: [String: Taint]? = nil,
            securityGroups: [Reference<SecurityGroup>]? = nil,
            antiAffinityGroups: [Reference<AntiAffinityGroup>]? = nil,
            privateNetworks: [Reference<PrivateNetwork>]? = nil,
            addons: [Addon]? = nil,
            kubeletImageGC: KubeletImageGC? = nil,
            kubeletMaxPods: Int? = nil,
            cpuManagerConfig: CPUManagerConfig? = nil,
            nvidiaMIGProfiles: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.state = state
            self.size = size
            self.version = version
            self.instanceType = instanceType
            self.template = template
            self.diskSize = diskSize
            self.instancePrefix = instancePrefix
            self.instancePool = instancePool
            self.deployTarget = deployTarget
            self.publicIPAssignment = publicIPAssignment
            self.labels = labels
            self.taints = taints
            self.securityGroups = securityGroups
            self.antiAffinityGroups = antiAffinityGroups
            self.privateNetworks = privateNetworks
            self.addons = addons
            self.kubeletImageGC = kubeletImageGC
            self.kubeletMaxPods = kubeletMaxPods
            self.cpuManagerConfig = cpuManagerConfig
            self.nvidiaMIGProfiles = nvidiaMIGProfiles
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, state, size, version, template, labels, taints, addons
            case instanceType = "instance-type"
            case diskSize = "disk-size"
            case instancePrefix = "instance-prefix"
            case instancePool = "instance-pool"
            case deployTarget = "deploy-target"
            case publicIPAssignment = "public-ip-assignment"
            case securityGroups = "security-groups"
            case antiAffinityGroups = "anti-affinity-groups"
            case privateNetworks = "private-networks"
            case kubeletImageGC = "kubelet-image-gc"
            case kubeletMaxPods = "kubelet-max-pods"
            case cpuManagerConfig = "cpu-manager-config"
            case nvidiaMIGProfiles = "nvidia-mig-profiles"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.SKSNodepool {
    /// The state of a node pool.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Being created.
        public static let creating = State(rawValue: "creating")
        /// Running.
        public static let running = State(rawValue: "running")
        /// Nodes are being added or removed.
        public static let scaling = State(rawValue: "scaling")
        /// Changes are being applied.
        public static let updating = State(rawValue: "updating")
        /// The nodes' bootstrap token is being renewed.
        public static let renewingToken = State(rawValue: "renewing-token")
        /// Running with some nodes unavailable.
        public static let degraded = State(rawValue: "degraded")
        /// Being deleted.
        public static let deleting = State(rawValue: "deleting")
        /// In an error state.
        public static let error = State(rawValue: "error")
    }

    /// A node pool add-on.
    struct Addon: RawRepresentable, Hashable, Codable, Sendable {
        /// The add-on as the API names it.
        public let rawValue: String

        /// Creates an add-on, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Local LVM storage on the nodes.
        public static let storageLVM = Addon(rawValue: "storage-lvm")
    }

    /// A Kubernetes taint's value and effect.
    struct Taint: Hashable, Codable, Sendable {
        /// The taint's value.
        public let value: String
        /// What the taint does to pods that don't tolerate it.
        public let effect: Effect

        /// Creates a taint.
        public init(value: String, effect: Effect) {
            self.value = value
            self.effect = effect
        }

        /// What a taint does to pods that don't tolerate it.
        public struct Effect: RawRepresentable, Hashable, Codable, Sendable {
            /// The effect as Kubernetes names it.
            public let rawValue: String

            /// Creates an effect, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// New pods aren't scheduled on the node.
            public static let noSchedule = Effect(rawValue: "NoSchedule")
            /// New pods avoid the node when they can.
            public static let preferNoSchedule = Effect(rawValue: "PreferNoSchedule")
            /// Running pods are evicted and new ones aren't scheduled.
            public static let noExecute = Effect(rawValue: "NoExecute")
        }
    }

    /// When the kubelet removes unused images.
    struct KubeletImageGC: Hashable, Codable, Sendable {
        /// The disk usage percentage that starts image removal.
        public let highThreshold: Int?
        /// The disk usage percentage image removal stops at.
        public let lowThreshold: Int?
        /// The minimum age of an unused image before it's removed, such as `2m`.
        public let minAge: String?

        /// Creates an image garbage collection configuration.
        public init(highThreshold: Int? = nil, lowThreshold: Int? = nil, minAge: String? = nil) {
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

    /// How the kubelet assigns CPUs to pods.
    struct CPUManagerConfig: Hashable, Codable, Sendable {
        /// The CPU management policy.
        public let policy: Policy?
        /// Options refining the static policy.
        public let policyOptions: [PolicyOption]?
        /// Resources reserved for Kubernetes components.
        public let kubeReserved: ReservedResources?
        /// Resources reserved for system components.
        public let systemReserved: ReservedResources?
        /// How often the CPU manager reconciles, as a duration such as `10s`.
        public let reconcilePeriod: String?

        /// Creates a CPU manager configuration.
        public init(
            policy: Policy? = nil,
            policyOptions: [PolicyOption]? = nil,
            kubeReserved: ReservedResources? = nil,
            systemReserved: ReservedResources? = nil,
            reconcilePeriod: String? = nil
        ) {
            self.policy = policy
            self.policyOptions = policyOptions
            self.kubeReserved = kubeReserved
            self.systemReserved = systemReserved
            self.reconcilePeriod = reconcilePeriod
        }

        enum CodingKeys: String, CodingKey {
            case policy = "cpu-manager-policy"
            case policyOptions = "cpu-manager-policy-options"
            case kubeReserved = "kube-reserved"
            case systemReserved = "system-reserved"
            case reconcilePeriod = "cpu-manager-reconcile-period"
        }

        /// A CPU management policy.
        public struct Policy: RawRepresentable, Hashable, Codable, Sendable {
            /// The policy as Kubernetes names it.
            public let rawValue: String

            /// Creates a policy, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The default: pods share CPUs.
            public static let none = Policy(rawValue: "none")
            /// Guaranteed pods requesting whole CPUs get exclusive ones.
            public static let `static` = Policy(rawValue: "static")
        }

        /// An option refining the static CPU management policy.
        public struct PolicyOption: RawRepresentable, Hashable, Codable, Sendable {
            /// The option as Kubernetes names it.
            public let rawValue: String

            /// Creates an option, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Align CPUs by socket.
            public static let alignBySocket = PolicyOption(rawValue: "align-by-socket")
            /// Spread CPUs across cores.
            public static let distributeCPUsAcrossCores = PolicyOption(rawValue: "distribute-cpus-across-cores")
            /// Spread CPUs across NUMA nodes.
            public static let distributeCPUsAcrossNUMA = PolicyOption(rawValue: "distribute-cpus-across-numa")
            /// Allocate whole physical cores only.
            public static let fullPCPUsOnly = PolicyOption(rawValue: "full-pcpus-only")
            /// Prefer CPUs sharing an uncore cache.
            public static let preferAlignCPUsByUncoreCache = PolicyOption(rawValue: "prefer-align-cpus-by-uncorecache")
            /// Keep reserved CPUs off-limits to pods.
            public static let strictCPUReservation = PolicyOption(rawValue: "strict-cpu-reservation")
        }
    }

    /// Resources reserved on each node.
    struct ReservedResources: Hashable, Codable, Sendable {
        /// The CPU reserved, such as `200m`.
        public let cpu: String
        /// The memory reserved, such as `512Mi`.
        public let memory: String?
        /// The ephemeral storage reserved, such as `1Gi`.
        public let ephemeralStorage: String?

        /// Creates a reservation.
        public init(cpu: String, memory: String? = nil, ephemeralStorage: String? = nil) {
            self.cpu = cpu
            self.memory = memory
            self.ephemeralStorage = ephemeralStorage
        }

        enum CodingKeys: String, CodingKey {
            case cpu, memory
            case ephemeralStorage = "ephemeral-storage"
        }
    }
}
