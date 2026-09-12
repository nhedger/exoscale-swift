/// Request body for updating an IAM role.
struct UpdateRoleRequest: Codable, Sendable {
    let description: String?
    let permissions: [Exoscale.Role.Permission]?
    let labels: [String: String]?
    let maxSessionTTL: Int?
    var assumeRolePolicy: Exoscale.IAMAssumeRolePolicy?

    enum CodingKeys: String, CodingKey {
        case description
        case permissions
        case labels
        case maxSessionTTL = "max-session-ttl"
        case assumeRolePolicy = "assume-role-policy"
    }
}
