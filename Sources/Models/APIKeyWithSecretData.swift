import Foundation

extension Exoscale.APIKeyWithSecret {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let key: String?
        let secret: String?
        let roleID: String?
    }
}

extension Exoscale.APIKeyWithSecret.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case secret
        case roleID = "role-id"
    }
}
