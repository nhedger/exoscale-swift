/// Request body for resizing a compute instance disk.
struct ResizeInstanceDiskRequest: Codable, Sendable {
    let diskSize: Int

    enum CodingKeys: String, CodingKey {
        case diskSize = "disk-size"
    }
}
