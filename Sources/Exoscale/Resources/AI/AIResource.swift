/// Access to AI API operations.
public final class AIResource: Sendable {
    let http: Http.Client

    /// Access to AI API key operations.
    public let apiKeys: AIAPIKeysResource

    /// Access to AI deployment API operations.
    public let deployments: DeploymentsResource

    /// Access to AI model API operations.
    public let models: ModelsResource

    /// Retrieves the organization's AI consumption quota in weighted units per minute.
    public func consumptionQuota() async throws -> Exoscale.AIConsumptionQuota {
        try await http.get(path: "/ai/quota", as: Exoscale.AIConsumptionQuota.self)
    }

    init(http: Http.Client) {
        self.http = http
        self.apiKeys = AIAPIKeysResource(http: http)
        self.deployments = DeploymentsResource(http: http)
        self.models = ModelsResource(http: http)
    }
}
