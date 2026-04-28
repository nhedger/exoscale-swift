/// Response for generating an SKS cluster kubeconfig.
public struct GenerateSKSClusterKubeconfigResponse: Codable, Sendable {
    public let kubeconfig: String
}
