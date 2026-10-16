import Foundation

extension Exoscale.LoadBalancer {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let description: String?
        let name: String?
        let state: State?
        let createdAt: Date?
        let ip: String?
        let services: [Service]?
        let labels: [String: String]?
    }
}

extension Exoscale.LoadBalancer.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case name
        case state
        case createdAt = "created-at"
        case ip
        case services
        case labels
    }
}
