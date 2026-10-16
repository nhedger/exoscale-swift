import Foundation

extension Exoscale.DBaaS.Integration {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let settings: [String: Exoscale.JSONValue]?
        let type: String?
        let isEnabled: Bool?
        let source: String?
        let isActive: Bool?
        let status: String?
        let id: String?
        let destination: String?
    }
}

extension Exoscale.DBaaS.Integration.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case settings
        case type
        case isEnabled = "is-enabled"
        case source
        case isActive = "is-active"
        case status
        case id
        case destination = "dest"
    }
}
