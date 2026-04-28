/// Access to AI API operations.
public final class AIResource: Sendable {
    let http: Http.Client

    /// Access to AI API key operations.
    public let apiKeys: AIAPIKeysResource

    /// Access to AI deployment API operations.
    public let deployments: DeploymentsResource

    /// Access to AI model API operations.
    public let models: ModelsResource

    init(http: Http.Client) {
        self.http = http
        self.apiKeys = AIAPIKeysResource(http: http)
        self.deployments = DeploymentsResource(http: http)
        self.models = ModelsResource(http: http)
    }
}
