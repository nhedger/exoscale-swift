/// Request body for updating a block storage volume.
struct UpdateBlockStorageVolumeRequest: Codable, Sendable {
    let name: String?
    let labels: [String: String]?
}
