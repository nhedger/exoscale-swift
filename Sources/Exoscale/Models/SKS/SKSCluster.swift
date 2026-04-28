public extension Exoscale {
    /// SKS cluster returned by the API.
    struct SKSCluster: Codable, Sendable {
        public enum CNI: String, Codable, Sendable {
            case calico
            case cilium
        }

        public enum State: String, Codable, Sendable {
            case rotatingCSICredentials = "rotating-csi-credentials"
            case rotatingCCMCredentials = "rotating-ccm-credentials"
            case creating
            case upgrading
            case deleting
            case running
            case suspending
            case updating
            case error
            case rotatingKarpenterCredentials = "rotating-karpenter-credentials"
            case resuming
        }

        public enum Level: String, Codable, Sendable {
            case starter
            case pro
        }

        public enum Addon: String, Codable, Sendable {
            case exoscaleCloudController = "exoscale-cloud-controller"
            case exoscaleContainerStorageInterface = "exoscale-container-storage-interface"
            case metricsServer = "metrics-server"
            case karpenter
        }

        public enum Authority: String, Codable, Sendable {
            case controlPlane = "control-plane"
            case aggregation
            case kubelet
        }

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
        public let createdAt: String?
        public let endpoint: String?

        enum CodingKeys: String, CodingKey {
            case description
            case labels
            case cni
            case autoUpgrade = "auto-upgrade"
            case name
            case enableOperatorsCA = "enable-operators-ca"
            case defaultSecurityGroupID = "default-security-group-id"
            case state
            case enableKubeProxy = "enable-kube-proxy"
            case nodepools
            case level
            case featureGates = "feature-gates"
            case addons
            case id
            case audit
            case version
            case createdAt = "created-at"
            case endpoint
        }
    }
}
