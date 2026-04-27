/// Request body for updating an SKS cluster.
struct UpdateSKSClusterRequest: Codable, Sendable {
    let description: String?
    let labels: [String: String]?
    let autoUpgrade: Bool?
    let oidc: Exoscale.SKSOIDC?
    let name: String?
    let enableOperatorsCA: Bool?
    let featureGates: [String]?
    let addons: [Exoscale.SKSCluster.Addon]?
    let audit: UpdateSKSClusterAuditRequest?

    enum CodingKeys: String, CodingKey {
        case description
        case labels
        case autoUpgrade = "auto-upgrade"
        case oidc
        case name
        case enableOperatorsCA = "enable-operators-ca"
        case featureGates = "feature-gates"
        case addons
        case audit
    }
}

/// Audit configuration for updating an SKS cluster.
struct UpdateSKSClusterAuditRequest: Codable, Sendable {
    let endpoint: String?
    let bearerToken: String?
    let initialBackoff: String?
    let enabled: Bool?

    enum CodingKeys: String, CodingKey {
        case endpoint
        case bearerToken = "bearer-token"
        case initialBackoff = "initial-backoff"
        case enabled
    }
}
