import Foundation

extension Exoscale.APIKey {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let key: String?
        let roleID: String?
    }
}

extension Exoscale.APIKey.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case roleID = "role-id"
    }
}
