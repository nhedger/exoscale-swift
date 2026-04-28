/// Request body for resizing a block storage volume.
struct ResizeBlockStorageVolumeRequest: Codable, Sendable {
    let size: Int
}
