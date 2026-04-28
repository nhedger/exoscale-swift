/// Request body for creating a Security Group.
struct CreateSecurityGroupRequest: Codable, Sendable {
    let name: String
    let description: String?
}
