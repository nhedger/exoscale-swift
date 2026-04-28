/// Response for retrieving inference engine parameter definitions.
public struct GetInferenceEngineHelpResponse: Codable, Sendable {
    public let parameters: [Exoscale.InferenceEngineParameter]
}
