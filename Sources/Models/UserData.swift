import Foundation

extension Exoscale.User {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let sso: Bool?
        let twoFactorAuthentication: Bool?
        let email: String?
        let id: String?
        let role: Exoscale.Role.Payload?
        let pending: Bool?
    }
}

extension Exoscale.User.Payload {
    enum CodingKeys: String, CodingKey {
        case sso
        case twoFactorAuthentication = "two-factor-authentication"
        case email
        case id
        case role
        case pending
    }
}
