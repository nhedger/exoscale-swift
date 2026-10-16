import Foundation

/// SSH key reference used by instance request bodies.
struct InstanceSSHKeyReference: Encodable, Sendable {
    let name: String
}
