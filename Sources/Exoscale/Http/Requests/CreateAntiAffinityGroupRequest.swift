/// Request body for creating an anti-affinity group.
struct CreateAntiAffinityGroupRequest: Codable, Sendable {
    let name: String
    let description: String?
}
