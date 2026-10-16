import Foundation

extension Exoscale.Snapshot {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let createdAt: Date?
        let state: State?
        let size: Int?
        let export: Export?
        let instance: Exoscale.Instance.Payload?
        let applicationConsistent: Bool?
    }
}

extension Exoscale.Snapshot.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created-at"
        case state
        case size
        case export
        case instance
        case applicationConsistent = "application-consistent"
    }
}
