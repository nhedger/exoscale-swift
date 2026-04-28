/// Request body for evicting Instance Pool members.
struct EvictInstancePoolMembersRequest: Codable, Sendable {
    let instances: [String]
}
