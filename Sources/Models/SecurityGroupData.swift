import Foundation

extension Exoscale.SecurityGroup {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let description: String?
        let externalSources: [String]?
        let rules: [Rule]?
    }
}

extension Exoscale.SecurityGroup.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case externalSources = "external-sources"
        case rules
    }
}
