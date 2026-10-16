import Foundation

extension Exoscale.AIAPIKeyWithValue {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let name: String?
        let scope: String?
        let id: String?
        let orgUUID: String?
        let createdAt: Date?
        let value: String?
    }
}

extension Exoscale.AIAPIKeyWithValue.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case name
        case scope
        case id
        case orgUUID = "org-uuid"
        case createdAt = "created-at"
        case value
    }
}
