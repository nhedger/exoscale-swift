import Foundation

/// Request body for updating a block storage volume.
struct UpdateBlockStorageVolumeBody: Encodable, Sendable {
    let name: String?
    let labels: [String: String]?
}
