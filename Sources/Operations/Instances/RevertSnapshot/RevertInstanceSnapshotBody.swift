import Foundation

/// Request body for reverting a compute instance to a snapshot.
struct RevertInstanceSnapshotBody: Encodable, Sendable {
    let id: String
}
