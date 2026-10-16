/// Access to SKS nodepool template API operations.
public struct NodepoolTemplatesResource: Sendable {
    public enum Variant: String, Sendable {
        case standard
        case nvidia
    }

    let http: Http.Client

    /// Retrieves the active SKS nodepool template for a Kubernetes version and variant.
    ///
    /// - Parameters:
    ///   - kubernetesVersion: The Kubernetes version.
    ///   - variant: The nodepool template variant.
    /// - Returns: The active template identifier returned by the API.
    public func activeTemplateID(
        kubernetesVersion: String,
        variant: Variant
    ) async throws -> String {
        try await http.execute(
            NodepoolTemplatesOperations.ActiveTemplateID(
                request: .init(kubernetesVersion: kubernetesVersion, variant: variant)
            )
        )
    }
}
