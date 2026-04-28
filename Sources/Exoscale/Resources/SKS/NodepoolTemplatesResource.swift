/// Access to SKS nodepool template API operations.
public struct NodepoolTemplatesResource {
    public enum Variant: String, Sendable {
        case standard
        case nvidia
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

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
        let response = try await http.get(
            path: "/sks-template/\(kubernetesVersion)/\(variant.rawValue)",
            as: ActiveNodepoolTemplateResponse.self
        )
        return response.activeTemplate
    }
}
