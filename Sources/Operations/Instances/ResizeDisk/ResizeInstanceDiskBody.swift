import Foundation

/// Request body for resizing a compute instance disk.
struct ResizeInstanceDiskBody: Encodable, Sendable {
    let diskSize: Int

    enum CodingKeys: String, CodingKey {
        case diskSize = "disk-size"
    }
}
