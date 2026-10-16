import Foundation

/// Response for generating an SKS cluster kubeconfig.
struct GenerateSKSClusterKubeconfigData: Decodable, Sendable {
    let kubeconfig: String
}
