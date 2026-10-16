import Foundation

/// Response for listing DNS domain records.
struct ListRecordsData: Decodable, Sendable {
    let records: [Exoscale.Record.Payload]

    enum CodingKeys: String, CodingKey {
        case records = "dns-domain-records"
    }
}
