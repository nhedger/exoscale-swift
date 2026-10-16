import Foundation

/// Response for listing AI models.
struct ListModelsData: Decodable, Sendable {
    let models: [Exoscale.Model.Payload]
}
