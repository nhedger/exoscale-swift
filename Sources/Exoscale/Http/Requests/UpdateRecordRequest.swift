/// Request body for updating a DNS domain record.
struct UpdateRecordRequest: Codable, Sendable {
    let name: String?
    let content: String?
    let ttl: Int?
    let priority: Int?
}
