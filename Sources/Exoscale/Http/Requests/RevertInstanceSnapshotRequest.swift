/// Request body for reverting a compute instance to a snapshot.
struct RevertInstanceSnapshotRequest: Codable, Sendable {
    let id: String
}
