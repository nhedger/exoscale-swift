/// Request body for adding or removing Security Group external sources.
struct SecurityGroupExternalSourceRequest: Codable, Sendable {
    let cidr: String
}
