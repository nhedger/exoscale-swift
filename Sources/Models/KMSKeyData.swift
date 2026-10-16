import Foundation

extension Exoscale.KMSKey {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let zone: String?
        let description: String?
        let rotation: RotationConfig?
        let revision: Revision?
        let name: String?
        let multiZone: Bool?
        let source: Source?
        let usage: Usage?
        let replicasStatus: [ReplicaState]?
        let status: Status?
        let statusSince: Date?
        let id: String?
        let replicas: [String]?
        let material: Material?
        let originZone: String?
        let createdAt: Date?
        let deleteAt: Date?
    }
}

extension Exoscale.KMSKey.Payload {
    enum CodingKeys: String, CodingKey {
        case zone
        case description
        case rotation
        case revision
        case name
        case multiZone = "multi-zone"
        case source
        case usage
        case replicasStatus = "replicas-status"
        case status
        case statusSince = "status-since"
        case id
        case replicas
        case material
        case originZone = "origin-zone"
        case createdAt = "created-at"
        case deleteAt = "delete-at"
    }
}
