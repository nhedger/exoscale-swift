/// Response for listing block storage snapshots.
public struct ListBlockStorageSnapshotsResponse: Codable, Sendable {
    public let blockStorageSnapshots: [Exoscale.BlockStorageSnapshot]

    enum CodingKeys: String, CodingKey {
        case blockStorageSnapshots = "block-storage-snapshots"
    }
}
