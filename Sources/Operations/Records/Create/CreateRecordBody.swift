import Foundation

/// Request body for creating a DNS domain record.
struct CreateRecordBody: Encodable, Sendable {
    let name: String
    let type: Exoscale.Record.RecordType
    let content: String
    let ttl: Int?
    let priority: Int?
}
