import Foundation

extension Exoscale.DBaaS.SettingsSchema {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let properties: [String: Exoscale.JSONValue]?
        let additionalProperties: Bool?
        let type: String?
        let title: String?
    }
}
