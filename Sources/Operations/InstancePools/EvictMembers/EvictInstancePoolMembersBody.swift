import Foundation

/// Request body for evicting Instance Pool members.
struct EvictInstancePoolMembersBody: Encodable, Sendable {
    let instances: [String]
}
