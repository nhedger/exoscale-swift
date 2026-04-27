/// Request body for creating a DNS domain record.
struct CreateRecordRequest: Codable, Sendable {
    let name: String
    let type: Exoscale.Record.RecordType
    let content: String
    let ttl: Int?
    let priority: Int?
}
