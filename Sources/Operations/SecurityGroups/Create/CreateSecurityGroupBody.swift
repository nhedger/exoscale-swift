import Foundation

/// Request body for creating a Security Group.
struct CreateSecurityGroupBody: Encodable, Sendable {
    let name: String
    let description: String?
}
