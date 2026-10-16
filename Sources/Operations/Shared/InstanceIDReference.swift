import Foundation

/// Identifier reference used by instance request bodies.
struct InstanceIDReference: Encodable, Sendable {
    let id: String
}
