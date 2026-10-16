import Foundation

/// Response for listing block storage snapshots.
struct ListBlockStorageSnapshotsData: Decodable, Sendable {
    let blockStorageSnapshots: [Exoscale.BlockStorageSnapshot.Payload]

    enum CodingKeys: String, CodingKey {
        case blockStorageSnapshots = "block-storage-snapshots"
    }
}
