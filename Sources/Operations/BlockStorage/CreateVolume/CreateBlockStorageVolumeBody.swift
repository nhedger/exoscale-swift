import Foundation

/// Request body for creating a block storage volume.
struct CreateBlockStorageVolumeBody: Encodable, Sendable {
    let name: String?
    let size: Int?
    let labels: [String: String]?
    let blockStorageSnapshot: BlockStorageSnapshotReference?

    enum CodingKeys: String, CodingKey {
        case name
        case size
        case labels
        case blockStorageSnapshot = "block-storage-snapshot"
    }
}
