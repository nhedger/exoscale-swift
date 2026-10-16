import Foundation

/// Block storage snapshot reference used by block storage request bodies.
struct BlockStorageSnapshotReference: Encodable, Sendable {
    let id: String
}
