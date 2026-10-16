import Foundation

extension Exoscale.AIAPIKey {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let name: String?
        let scope: String?
        let id: String?
        let orgUUID: String?
        let createdAt: Date?
    }
}

extension Exoscale.AIAPIKey.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case name
        case scope
        case id
        case orgUUID = "org-uuid"
        case createdAt = "created-at"
    }
}
