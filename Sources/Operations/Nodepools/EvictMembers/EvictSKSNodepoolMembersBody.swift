import Foundation

/// Request body for evicting SKS nodepool members.
struct EvictSKSNodepoolMembersBody: Encodable, Sendable {
    let instances: [String]
}
