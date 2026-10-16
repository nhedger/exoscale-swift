import Foundation

/// Request body for creating a block storage snapshot.
struct CreateBlockStorageSnapshotBody: Encodable, Sendable {
    let name: String?
    let labels: [String: String]?
}
