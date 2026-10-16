import Foundation

extension Exoscale.Role {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let labels: [String: String]?
        let permissions: [Permission]?
        let assumeRolePolicy: Exoscale.IAMAssumeRolePolicy?
        let editable: Bool?
        let name: String?
        let maxSessionTTL: Int?
        let policy: Exoscale.IAMPolicy?
        let id: String?
    }
}

extension Exoscale.Role.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case labels
        case permissions
        case assumeRolePolicy = "assume-role-policy"
        case editable
        case name
        case maxSessionTTL = "max-session-ttl"
        case policy
        case id
    }
}
