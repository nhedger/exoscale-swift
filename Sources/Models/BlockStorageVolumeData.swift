import Foundation

extension Exoscale.BlockStorageVolume {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let labels: [String: String]?
        let instance: Exoscale.Instance.Reference?
        let name: String?
        let state: State?
        let size: Int?
        let encrypted: Bool?
        let blockSize: Int?
        let blockStorageSnapshots: [Exoscale.BlockStorageSnapshot.Reference]?
        let id: String?
        let createdAt: Date?
    }
}

extension Exoscale.BlockStorageVolume.Payload {
    enum CodingKeys: String, CodingKey {
        case labels
        case instance
        case name
        case state
        case size
        case encrypted
        case blockSize = "blocksize"
        case blockStorageSnapshots = "block-storage-snapshots"
        case id
        case createdAt = "created-at"
    }
}
