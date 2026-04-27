/// Request body for updating a PTR DNS record.
struct UpdateReverseDNSRecordRequest: Codable, Sendable {
    let domainName: String

    init(domainName: String) {
        self.domainName = domainName
    }

    enum CodingKeys: String, CodingKey {
        case domainName = "domain-name"
    }
}
