/// Response for listing AI models.
public struct ListModelsResponse: Codable, Sendable {
    public let models: [Exoscale.Model]
}
