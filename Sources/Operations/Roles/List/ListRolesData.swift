import Foundation

/// Response for listing IAM roles.
struct ListRolesData: Decodable, Sendable {
    let roles: [Exoscale.Role.Payload]

    enum CodingKeys: String, CodingKey {
        case roles = "iam-roles"
    }
}
