import Foundation

/// Request body for assuming an IAM role.
struct AssumeRoleBody: Encodable, Sendable {
    let ttl: Int
}
