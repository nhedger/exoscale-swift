/// Request body for evicting SKS nodepool members.
struct EvictSKSNodepoolMembersRequest: Codable, Sendable {
    let instances: [String]
}
