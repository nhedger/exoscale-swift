import Foundation

/// Response for retrieving inference engine parameter definitions.
struct GetInferenceEngineHelpData: Decodable, Sendable {
    let parameters: [Exoscale.InferenceEngineParameter.Payload]
}
