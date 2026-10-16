import Foundation

extension Exoscale.SKSCluster {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let labels: [String: String]?
        let cni: CNI?
        let autoUpgrade: Bool?
        let name: String?
        let enableOperatorsCA: Bool?
        let defaultSecurityGroupID: String?
        let state: State?
        let enableKubeProxy: Bool?
        let nodepools: [Exoscale.SKSNodepool.Payload]?
        let level: Level?
        let featureGates: [String]?
        let addons: [Addon]?
        let id: String?
        let audit: Exoscale.SKSAudit?
        let version: String?
        let createdAt: Date?
        let endpoint: String?
        let oidc: Exoscale.SKSOIDC?
    }
}

extension Exoscale.SKSCluster.Payload {
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
        case oidc
    }
}
