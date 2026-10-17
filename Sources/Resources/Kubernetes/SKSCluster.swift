import Foundation

public extension Exoscale {
    /// A managed Kubernetes cluster (SKS).
    struct SKSCluster: Hashable, Codable, Sendable {
        /// The cluster's identifier.
        public let id: String
        /// The cluster's name.
        public let name: String?
        /// The cluster's description.
        public let description: String?
        /// Whether the cluster is running or changing state.
        public let state: State?
        /// The Kubernetes version.
        public let version: String?
        /// The service level.
        public let level: Level?
        /// The container network plugin.
        public let cni: CNI?
        /// The API server's URL.
        public let endpoint: String?
        /// Whether the control plane is upgraded to new patch versions automatically.
        public let autoUpgrade: Bool?
        /// Whether the Kubernetes network proxy is deployed.
        public let enableKubeProxy: Bool?
        /// Whether the API server trusts the operators' certificate authority.
        public let enableOperatorsCA: Bool?
        /// The security group created for the cluster's nodes.
        public let defaultSecurityGroupID: String?
        /// The add-ons deployed in the cluster.
        public let addons: [Addon]?
        /// The Kubernetes alpha features enabled on the API server.
        public let featureGates: [String]?
        /// The Karpenter controller feature gates enabled.
        public let karpenterFeatureGates: [String]?
        /// The networks allowed to reach the API server, as CIDRs (experimental).
        public let allowedNetworks: [String]?
        /// The OpenID Connect provider users authenticate with.
        public let oidc: OIDC?
        /// Where the API server sends its audit log.
        public let audit: Audit?
        /// The cluster's node pools.
        public let nodepools: [SKSNodepool]?
        /// The labels attached to the cluster.
        public let labels: [String: String]?
        /// When the cluster was created.
        public let createdAt: Date?

        /// Creates a cluster, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            state: State? = nil,
            version: String? = nil,
            level: Level? = nil,
            cni: CNI? = nil,
            endpoint: String? = nil,
            autoUpgrade: Bool? = nil,
            enableKubeProxy: Bool? = nil,
            enableOperatorsCA: Bool? = nil,
            defaultSecurityGroupID: String? = nil,
            addons: [Addon]? = nil,
            featureGates: [String]? = nil,
            karpenterFeatureGates: [String]? = nil,
            allowedNetworks: [String]? = nil,
            oidc: OIDC? = nil,
            audit: Audit? = nil,
            nodepools: [SKSNodepool]? = nil,
            labels: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.state = state
            self.version = version
            self.level = level
            self.cni = cni
            self.endpoint = endpoint
            self.autoUpgrade = autoUpgrade
            self.enableKubeProxy = enableKubeProxy
            self.enableOperatorsCA = enableOperatorsCA
            self.defaultSecurityGroupID = defaultSecurityGroupID
            self.addons = addons
            self.featureGates = featureGates
            self.karpenterFeatureGates = karpenterFeatureGates
            self.allowedNetworks = allowedNetworks
            self.oidc = oidc
            self.audit = audit
            self.nodepools = nodepools
            self.labels = labels
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, state, version, level, cni, endpoint, addons, oidc, audit, nodepools, labels
            case autoUpgrade = "auto-upgrade"
            case enableKubeProxy = "enable-kube-proxy"
            case enableOperatorsCA = "enable-operators-ca"
            case defaultSecurityGroupID = "default-security-group-id"
            case featureGates = "feature-gates"
            case karpenterFeatureGates = "karpenter-feature-gates"
            case allowedNetworks = "allowed-networks"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.SKSCluster {
    /// The state of a cluster.
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
        /// Changes are being applied.
        public static let updating = State(rawValue: "updating")
        /// Being upgraded to a new Kubernetes version.
        public static let upgrading = State(rawValue: "upgrading")
        /// Being suspended.
        public static let suspending = State(rawValue: "suspending")
        /// Being resumed.
        public static let resuming = State(rawValue: "resuming")
        /// The cloud controller manager's credentials are being rotated.
        public static let rotatingCCMCredentials = State(rawValue: "rotating-ccm-credentials")
        /// The storage driver's credentials are being rotated.
        public static let rotatingCSICredentials = State(rawValue: "rotating-csi-credentials")
        /// Karpenter's credentials are being rotated.
        public static let rotatingKarpenterCredentials = State(rawValue: "rotating-karpenter-credentials")
        /// Being deleted.
        public static let deleting = State(rawValue: "deleting")
        /// In an error state.
        public static let error = State(rawValue: "error")
    }

    /// A cluster's service level.
    struct Level: RawRepresentable, Hashable, Codable, Sendable {
        /// The level as the API names it.
        public let rawValue: String

        /// Creates a level, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The free starter level.
        public static let starter = Level(rawValue: "starter")
        /// The pro level, with a highly available control plane.
        public static let pro = Level(rawValue: "pro")
    }

    /// A container network plugin.
    struct CNI: RawRepresentable, Hashable, Codable, Sendable {
        /// The plugin as the API names it.
        public let rawValue: String

        /// Creates a plugin, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Calico.
        public static let calico = CNI(rawValue: "calico")
        /// Cilium.
        public static let cilium = CNI(rawValue: "cilium")
    }

    /// An add-on deployed in a cluster.
    struct Addon: RawRepresentable, Hashable, Codable, Sendable {
        /// The add-on as the API names it.
        public let rawValue: String

        /// Creates an add-on, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The Exoscale cloud controller manager.
        public static let cloudController = Addon(rawValue: "exoscale-cloud-controller")
        /// The Exoscale storage driver.
        public static let containerStorageInterface = Addon(rawValue: "exoscale-container-storage-interface")
        /// The Kubernetes metrics server.
        public static let metricsServer = Addon(rawValue: "metrics-server")
        /// Karpenter, the node autoscaler.
        public static let karpenter = Addon(rawValue: "karpenter")
    }

    /// The OpenID Connect provider a cluster's users authenticate with.
    struct OIDC: Hashable, Codable, Sendable {
        /// The OpenID client identifier.
        public let clientID: String
        /// The provider's URL.
        public let issuerURL: String
        /// The JWT claim used as the user name.
        public let usernameClaim: String?
        /// The prefix added to user names.
        public let usernamePrefix: String?
        /// The JWT claim used as the user's groups.
        public let groupsClaim: String?
        /// The prefix added to group names.
        public let groupsPrefix: String?
        /// Claims the ID token must contain, with their values.
        public let requiredClaim: [String: String]?

        /// Creates an OpenID Connect configuration.
        public init(
            clientID: String,
            issuerURL: String,
            usernameClaim: String? = nil,
            usernamePrefix: String? = nil,
            groupsClaim: String? = nil,
            groupsPrefix: String? = nil,
            requiredClaim: [String: String]? = nil
        ) {
            self.clientID = clientID
            self.issuerURL = issuerURL
            self.usernameClaim = usernameClaim
            self.usernamePrefix = usernamePrefix
            self.groupsClaim = groupsClaim
            self.groupsPrefix = groupsPrefix
            self.requiredClaim = requiredClaim
        }

        enum CodingKeys: String, CodingKey {
            case clientID = "client-id"
            case issuerURL = "issuer-url"
            case usernameClaim = "username-claim"
            case usernamePrefix = "username-prefix"
            case groupsClaim = "groups-claim"
            case groupsPrefix = "groups-prefix"
            case requiredClaim = "required-claim"
        }
    }

    /// Where a cluster's API server sends its audit log.
    ///
    /// The API never returns the bearer token, so it is only set when creating or updating.
    struct Audit: Hashable, Codable, Sendable {
        /// The URL of the web server receiving the log.
        public let endpoint: String?
        /// The token sent to the web server.
        public let bearerToken: String?
        /// The first delay before retrying a failed delivery, such as `10s`.
        public let initialBackoff: String?
        /// Whether the log is sent.
        public let enabled: Bool?

        /// Creates an audit configuration.
        public init(
            endpoint: String? = nil,
            bearerToken: String? = nil,
            initialBackoff: String? = nil,
            enabled: Bool? = nil
        ) {
            self.endpoint = endpoint
            self.bearerToken = bearerToken
            self.initialBackoff = initialBackoff
            self.enabled = enabled
        }

        enum CodingKeys: String, CodingKey {
            case endpoint, enabled
            case bearerToken = "bearer-token"
            case initialBackoff = "initial-backoff"
        }
    }

    /// The pod and service networks of a cluster, set when it's created.
    struct Networking: Hashable, Codable, Sendable {
        /// The pods' network, as up to two comma-separated CIDRs.
        public let clusterCIDR: String?
        /// The services' network, as up to two comma-separated CIDRs.
        public let serviceClusterIPRange: String?
        /// The size of each node's IPv4 pod network. The API defaults to 24.
        public let nodeCIDRMaskSizeIPv4: Int?
        /// The size of each node's IPv6 pod network. The API defaults to 64.
        public let nodeCIDRMaskSizeIPv6: Int?

        /// Creates a network configuration.
        public init(
            clusterCIDR: String? = nil,
            serviceClusterIPRange: String? = nil,
            nodeCIDRMaskSizeIPv4: Int? = nil,
            nodeCIDRMaskSizeIPv6: Int? = nil
        ) {
            self.clusterCIDR = clusterCIDR
            self.serviceClusterIPRange = serviceClusterIPRange
            self.nodeCIDRMaskSizeIPv4 = nodeCIDRMaskSizeIPv4
            self.nodeCIDRMaskSizeIPv6 = nodeCIDRMaskSizeIPv6
        }

        enum CodingKeys: String, CodingKey {
            case clusterCIDR = "cluster-cidr"
            case serviceClusterIPRange = "service-cluster-ip-range"
            case nodeCIDRMaskSizeIPv4 = "node-cidr-mask-size-ipv4"
            case nodeCIDRMaskSizeIPv6 = "node-cidr-mask-size-ipv6"
        }
    }

    /// A Kubernetes API a cluster uses that a future version removes.
    struct DeprecatedResource: Hashable, Codable, Sendable {
        /// The API group.
        public let group: String?
        /// The API version.
        public let version: String?
        /// The resource.
        public let resource: String?
        /// The subresource.
        public let subresource: String?
        /// The Kubernetes release that removes it.
        public let removedRelease: String?

        /// Creates a deprecated resource, for example for previews and tests.
        public init(
            group: String? = nil,
            version: String? = nil,
            resource: String? = nil,
            subresource: String? = nil,
            removedRelease: String? = nil
        ) {
            self.group = group
            self.version = version
            self.resource = resource
            self.subresource = subresource
            self.removedRelease = removedRelease
        }

        enum CodingKeys: String, CodingKey {
            case group, version, resource, subresource
            case removedRelease = "removed-release"
        }
    }

    /// A certificate authority of a cluster.
    struct Authority: RawRepresentable, Hashable, Sendable {
        /// The authority as the API names it.
        public let rawValue: String

        /// Creates an authority, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The control plane's authority.
        public static let controlPlane = Authority(rawValue: "control-plane")
        /// The aggregation layer's authority.
        public static let aggregation = Authority(rawValue: "aggregation")
        /// The kubelets' authority.
        public static let kubelet = Authority(rawValue: "kubelet")
    }
}
