import Foundation

/// Request body for updating a DNS domain record.
struct UpdateRecordBody: Encodable, Sendable {
    let name: String?
    let content: String?
    let ttl: Int?
    let priority: Int?
}
