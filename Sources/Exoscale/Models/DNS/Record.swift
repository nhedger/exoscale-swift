public extension Exoscale {
    /// DNS domain record returned by the API.
    struct Record: Codable, Sendable {
        public enum RecordType: String, Codable, Sendable {
            case ns = "NS"
            case caa = "CAA"
            case naptr = "NAPTR"
            case pool = "POOL"
            case a = "A"
            case hinfo = "HINFO"
            case cname = "CNAME"
            case soa = "SOA"
            case sshfp = "SSHFP"
            case srv = "SRV"
            case aaaa = "AAAA"
            case mx = "MX"
            case txt = "TXT"
            case alias = "ALIAS"
            case url = "URL"
            case spf = "SPF"
        }

        public let updatedAt: String?
        public let content: String?
        public let name: String?
        public let type: RecordType?
        public let ttl: Int?
        public let priority: Int?
        public let id: String?
        public let createdAt: String?
        public let systemRecord: Bool?

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
}
