import Foundation

extension Exoscale.AssumedRoleCredentials {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let key: String?
        let name: String?
        let orgID: String?
        let roleID: String?
        let secret: String?
        let expiresAt: Date?
    }
}

extension Exoscale.AssumedRoleCredentials.Payload {
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case orgID = "org-id"
        case roleID = "role-id"
        case secret
        case expiresAt = "expires-at"
    }
}
