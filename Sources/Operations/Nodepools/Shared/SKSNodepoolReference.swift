import Foundation

/// Identifier reference used by SKS nodepool request bodies.
struct SKSNodepoolReference: Encodable, Sendable {
    let id: String
}
