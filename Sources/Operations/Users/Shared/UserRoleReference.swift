import Foundation

/// IAM role reference used by user request bodies.
struct UserRoleReference: Encodable, Sendable {
    let id: String
}
