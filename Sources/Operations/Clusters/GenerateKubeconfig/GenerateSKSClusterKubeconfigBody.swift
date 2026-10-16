import Foundation

/// Request body for generating an SKS cluster kubeconfig.
struct GenerateSKSClusterKubeconfigBody: Encodable, Sendable {
    let ttl: Int?
    let user: String
    let groups: [String]
}
