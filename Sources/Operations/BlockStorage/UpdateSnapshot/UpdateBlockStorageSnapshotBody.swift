import Foundation

/// Request body for updating a block storage snapshot.
struct UpdateBlockStorageSnapshotBody: Encodable, Sendable {
    let name: String?
    let labels: [String: String]?
}
