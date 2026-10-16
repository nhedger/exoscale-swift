import Foundation

/// Request body for updating an SKS cluster.
struct UpdateSKSClusterBody: Encodable, Sendable {
    let description: String?
    let labels: [String: String]?
    let autoUpgrade: Bool?
    let oidc: Exoscale.SKSOIDC?
    let name: String?
    let enableOperatorsCA: Bool?
    let featureGates: [String]?
    let addons: [Exoscale.SKSCluster.Addon]?
    let audit: UpdateSKSClusterAuditBody?

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
