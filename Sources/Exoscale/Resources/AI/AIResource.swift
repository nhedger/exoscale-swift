/// Access to AI API operations.
public final class AIResource {
    let http: Http.Client

    /// Access to AI API key operations.
    public lazy var apiKeys = AIAPIKeysResource(http: http)

    /// Access to AI deployment API operations.
    public lazy var deployments = DeploymentsResource(http: http)

    /// Access to AI model API operations.
    public lazy var models = ModelsResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
