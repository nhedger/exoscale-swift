public extension Exoscale {
    /// PTR DNS record returned by the API.
    struct ReverseDNSRecord: Codable, Sendable {
        public let domainName: String?

        enum CodingKeys: String, CodingKey {
            case domainName = "domain-name"
        }
    }
}
