import Foundation

extension Exoscale.InstanceType {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let size: Size?
        let family: Family?
        let cpus: Int?
        let gpus: Int?
        let authorized: Bool?
        let memory: Int?
        let zones: [Exoscale.ZoneName]?
    }
}

extension Exoscale.InstanceType.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case size
        case family
        case cpus
        case gpus
        case authorized
        case memory
        case zones
    }
}
