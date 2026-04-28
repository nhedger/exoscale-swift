/// Request body for generating an SKS cluster kubeconfig.
struct GenerateSKSClusterKubeconfigRequest: Codable, Sendable {
    let ttl: Int?
    let user: String
    let groups: [String]
}
