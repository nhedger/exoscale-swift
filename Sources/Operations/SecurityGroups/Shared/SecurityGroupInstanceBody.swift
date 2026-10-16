import Foundation

/// Request body for Security Group instance attachment operations.
struct SecurityGroupInstanceBody: Encodable, Sendable {
    let instance: InstanceIDReference
}
