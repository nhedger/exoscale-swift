import Foundation

/// Request body for updating a PTR DNS record.
struct UpdateReverseDNSRecordBody: Encodable, Sendable {
    let domainName: String

    enum CodingKeys: String, CodingKey {
        case domainName = "domain-name"
    }
}
