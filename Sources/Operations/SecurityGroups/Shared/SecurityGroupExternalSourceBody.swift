import Foundation

/// Request body for adding or removing Security Group external sources.
struct SecurityGroupExternalSourceBody: Encodable, Sendable {
    let cidr: String
}
