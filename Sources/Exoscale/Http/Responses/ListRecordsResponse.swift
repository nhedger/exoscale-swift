/// Response for listing DNS domain records.
public struct ListRecordsResponse: Codable, Sendable {
    public let records: [Exoscale.Record]

    enum CodingKeys: String, CodingKey {
        case records = "dns-domain-records"
    }
}
