/// Request body for creating an IAM role.
struct CreateRoleRequest: Codable, Sendable {
    let name: String
    let description: String?
    let permissions: [Exoscale.Role.Permission]?
    let editable: Bool?
    let labels: [String: String]?
    let policy: Exoscale.IAMPolicy?
    let assumeRolePolicy: Exoscale.IAMPolicy?
    let maxSessionTTL: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case permissions
        case editable
        case labels
        case policy
        case assumeRolePolicy = "assume-role-policy"
        case maxSessionTTL = "max-session-ttl"
    }
}
