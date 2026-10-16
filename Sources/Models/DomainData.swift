import Foundation

extension Exoscale.Domain {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let createdAt: Date?
        let unicodeName: String?
    }
}

extension Exoscale.Domain.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created-at"
        case unicodeName = "unicode-name"
    }
}
