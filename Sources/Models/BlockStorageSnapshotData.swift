import Foundation

extension Exoscale.BlockStorageSnapshot {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let size: Int?
        let volumeSize: Int?
        let createdAt: Date?
        let state: State?
        let labels: [String: String]?
        let blockStorageVolume: Exoscale.BlockStorageVolume.Reference?
    }
}

extension Exoscale.BlockStorageSnapshot.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case size
        case volumeSize = "volume-size"
        case createdAt = "created-at"
        case state
        case labels
        case blockStorageVolume = "block-storage-volume"
    }
}
