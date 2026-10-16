import Foundation

extension Exoscale.InferenceEngineParameter {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let allowedValues: [String]?
        let defaultValue: String?
        let name: String?
        let section: String?
        let type: String?
        let flags: [String]?
    }
}

extension Exoscale.InferenceEngineParameter.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case allowedValues = "allowed-values"
        case defaultValue = "default"
        case name
        case section
        case type
        case flags
    }
}
