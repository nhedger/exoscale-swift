import Foundation

extension Exoscale.Record {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let content: String?
        let name: String?
        let type: RecordType?
        let ttl: Int?
        let priority: Int?
        let id: String?
        let createdAt: Date?
        let systemRecord: Bool?
    }
}

extension Exoscale.Record.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case content
        case name
        case type
        case ttl
        case priority
        case id
        case createdAt = "created-at"
        case systemRecord = "system-record"
    }
}
