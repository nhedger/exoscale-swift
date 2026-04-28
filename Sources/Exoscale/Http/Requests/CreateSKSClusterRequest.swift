/// Request body for creating an SKS cluster.
struct CreateSKSClusterRequest: Codable, Sendable {
    let description: String?
    let labels: [String: String]?
    let cni: Exoscale.SKSCluster.CNI?
    let autoUpgrade: Bool?
    let networking: Exoscale.SKSClusterNetworking?
    let oidc: Exoscale.SKSOIDC?
    let name: String
    let createDefaultSecurityGroup: Bool?
    let enableKubeProxy: Bool?
    let level: Exoscale.SKSCluster.Level
    let featureGates: [String]?
    let addons: [Exoscale.SKSCluster.Addon]?
    let audit: CreateSKSClusterAuditRequest?
    let version: String

    enum CodingKeys: String, CodingKey {
        case description
        case labels
        case cni
        case autoUpgrade = "auto-upgrade"
        case networking
        case oidc
        case name
        case createDefaultSecurityGroup = "create-default-security-group"
        case enableKubeProxy = "enable-kube-proxy"
        case level
        case featureGates = "feature-gates"
        case addons
        case audit
        case version
    }
}

/// Audit configuration for creating an SKS cluster.
struct CreateSKSClusterAuditRequest: Codable, Sendable {
    let endpoint: String?
    let bearerToken: String?
    let initialBackoff: String?

    enum CodingKeys: String, CodingKey {
        case endpoint
        case bearerToken = "bearer-token"
        case initialBackoff = "initial-backoff"
    }
}
