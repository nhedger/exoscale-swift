/// Response for listing IAM roles.
public struct ListRolesResponse: Codable, Sendable {
    public let roles: [Exoscale.Role]

    enum CodingKeys: String, CodingKey {
        case roles = "iam-roles"
    }
}
