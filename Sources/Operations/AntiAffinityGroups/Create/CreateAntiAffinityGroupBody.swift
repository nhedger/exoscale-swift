import Foundation

/// Request body for creating an anti-affinity group.
struct CreateAntiAffinityGroupBody: Encodable, Sendable {
    let name: String
    let description: String?
}
