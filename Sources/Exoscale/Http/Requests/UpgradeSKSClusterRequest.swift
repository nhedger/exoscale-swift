/// Request body for upgrading an SKS cluster.
struct UpgradeSKSClusterRequest: Codable, Sendable {
    let version: String
}
