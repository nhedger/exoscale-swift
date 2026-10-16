import Foundation

extension Exoscale.VPC {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let description: String?
        let createdAt: Date?
        let labels: [String: String]?
    }
}

extension Exoscale.VPC.Payload {
    enum CodingKeys: String, CodingKey {
        case id, name, description, labels
        case createdAt = "created-at"
    }
}
