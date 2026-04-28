/// Request body for updating a block storage snapshot.
struct UpdateBlockStorageSnapshotRequest: Codable, Sendable {
    let name: String?
    let labels: [String: String]?
}
