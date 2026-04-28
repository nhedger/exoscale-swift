/// Request body for creating a block storage snapshot.
struct CreateBlockStorageSnapshotRequest: Codable, Sendable {
    let name: String?
    let labels: [String: String]?
}
