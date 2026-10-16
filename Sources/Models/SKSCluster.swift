import Foundation

public extension Exoscale {
    /// SKS cluster returned by the API.
    struct SKSCluster: Hashable, Sendable {
        public let description: String?
        public let labels: [String: String]?
        public let cni: CNI?
        public let autoUpgrade: Bool?
        public let name: String?
        public let enableOperatorsCA: Bool?
        public let defaultSecurityGroupID: String?
        public let state: State?
        public let enableKubeProxy: Bool?
        public let nodepools: [Exoscale.SKSNodepool]?
        public let level: Level?
        public let featureGates: [String]?
        public let addons: [Addon]?
        public let id: String?
        public let audit: Exoscale.SKSAudit?
        public let version: String?
        public let createdAt: Date?
        public let endpoint: String?
        public let oidc: SKSOIDC?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            labels: [String: String]? = nil,
            cni: CNI? = nil,
            autoUpgrade: Bool? = nil,
            name: String? = nil,
            enableOperatorsCA: Bool? = nil,
            defaultSecurityGroupID: String? = nil,
            state: State? = nil,
            enableKubeProxy: Bool? = nil,
            nodepools: [Exoscale.SKSNodepool]? = nil,
            level: Level? = nil,
            featureGates: [String]? = nil,
            addons: [Addon]? = nil,
            id: String? = nil,
            audit: Exoscale.SKSAudit? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            endpoint: String? = nil,
            oidc: SKSOIDC? = nil
        ) {
            self.description = description
            self.labels = labels
            self.cni = cni
            self.autoUpgrade = autoUpgrade
            self.name = name
            self.enableOperatorsCA = enableOperatorsCA
            self.defaultSecurityGroupID = defaultSecurityGroupID
            self.state = state
            self.enableKubeProxy = enableKubeProxy
            self.nodepools = nodepools
            self.level = level
            self.featureGates = featureGates
            self.addons = addons
            self.id = id
            self.audit = audit
            self.version = version
            self.createdAt = createdAt
            self.endpoint = endpoint
            self.oidc = oidc
        }

        init(data: Payload, client: Http.Client) {
            description = data.description
            labels = data.labels
            cni = data.cni
            autoUpgrade = data.autoUpgrade
            name = data.name
            enableOperatorsCA = data.enableOperatorsCA
            defaultSecurityGroupID = data.defaultSecurityGroupID
            state = data.state
            enableKubeProxy = data.enableKubeProxy
            nodepools = data.nodepools.map { $0.map { Exoscale.SKSNodepool(data: $0, client: client) } }
            level = data.level
            featureGates = data.featureGates
            addons = data.addons
            id = data.id
            audit = data.audit
            version = data.version
            createdAt = data.createdAt
            endpoint = data.endpoint
            oidc = data.oidc
        }
    }
}

public extension Exoscale.SKSCluster {
    enum CNI: Exoscale.ExtensibleEnum {
        case calico
        case cilium
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.calico, .cilium]

        public var rawValue: String {
            switch self {
            case .calico: "calico"
            case .cilium: "cilium"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSCluster {
    enum State: Exoscale.ExtensibleEnum {
        case rotatingCSICredentials
        case rotatingCCMCredentials
        case creating
        case upgrading
        case deleting
        case running
        case suspending
        case updating
        case error
        case rotatingKarpenterCredentials
        case resuming
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .rotatingCSICredentials,
            .rotatingCCMCredentials,
            .creating,
            .upgrading,
            .deleting,
            .running,
            .suspending,
            .updating,
            .error,
            .rotatingKarpenterCredentials,
            .resuming
        ]

        public var rawValue: String {
            switch self {
            case .rotatingCSICredentials: "rotating-csi-credentials"
            case .rotatingCCMCredentials: "rotating-ccm-credentials"
            case .creating: "creating"
            case .upgrading: "upgrading"
            case .deleting: "deleting"
            case .running: "running"
            case .suspending: "suspending"
            case .updating: "updating"
            case .error: "error"
            case .rotatingKarpenterCredentials: "rotating-karpenter-credentials"
            case .resuming: "resuming"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSCluster {
    enum Level: Exoscale.ExtensibleEnum {
        case starter
        case pro
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.starter, .pro]

        public var rawValue: String {
            switch self {
            case .starter: "starter"
            case .pro: "pro"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSCluster {
    enum Addon: Exoscale.ExtensibleEnum {
        case exoscaleCloudController
        case exoscaleContainerStorageInterface
        case metricsServer
        case karpenter
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .exoscaleCloudController,
            .exoscaleContainerStorageInterface,
            .metricsServer,
            .karpenter
        ]

        public var rawValue: String {
            switch self {
            case .exoscaleCloudController: "exoscale-cloud-controller"
            case .exoscaleContainerStorageInterface: "exoscale-container-storage-interface"
            case .metricsServer: "metrics-server"
            case .karpenter: "karpenter"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSCluster {
    enum Authority: Exoscale.ExtensibleEnum {
        case controlPlane
        case aggregation
        case kubelet
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.controlPlane, .aggregation, .kubelet]

        public var rawValue: String {
            switch self {
            case .controlPlane: "control-plane"
            case .aggregation: "aggregation"
            case .kubelet: "kubelet"
            case let .unknown(value): value
            }
        }
    }
}
