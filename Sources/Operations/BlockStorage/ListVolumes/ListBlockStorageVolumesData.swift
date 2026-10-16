import Foundation

/// Response for listing block storage volumes.
struct ListBlockStorageVolumesData: Decodable, Sendable {
    let blockStorageVolumes: [Exoscale.BlockStorageVolume.Payload]

    enum CodingKeys: String, CodingKey {
        case blockStorageVolumes = "block-storage-volumes"
    }
}
