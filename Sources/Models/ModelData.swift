import Foundation

extension Exoscale.Model {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let name: String?
        let state: State?
        let id: String?
        let modelSize: Int?
        let createdAt: Date?
    }
}

extension Exoscale.Model.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case name
        case state
        case id
        case modelSize = "model-size"
        case createdAt = "created-at"
    }
}
