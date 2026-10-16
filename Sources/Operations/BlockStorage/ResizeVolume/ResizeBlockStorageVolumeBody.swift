import Foundation

/// Request body for resizing a block storage volume.
struct ResizeBlockStorageVolumeBody: Encodable, Sendable {
    let size: Int
}
