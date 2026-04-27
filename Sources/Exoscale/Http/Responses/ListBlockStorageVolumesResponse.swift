/// Response for listing block storage volumes.
public struct ListBlockStorageVolumesResponse: Codable, Sendable {
    public let blockStorageVolumes: [Exoscale.BlockStorageVolume]

    enum CodingKeys: String, CodingKey {
        case blockStorageVolumes = "block-storage-volumes"
    }
}
