/// Request body for assuming an IAM role.
struct AssumeRoleRequest: Codable, Sendable {
    let ttl: Int?
}
