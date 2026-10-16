import Foundation

public extension Exoscale {
    /// DNS domain record returned by the API.
    struct Record: Hashable, Sendable {
        public let updatedAt: Date?
        public let content: String?
        public let name: String?
        public let type: RecordType?
        public let ttl: Int?
        public let priority: Int?
        public let id: String?
        public let createdAt: Date?
        public let systemRecord: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            content: String? = nil,
            name: String? = nil,
            type: RecordType? = nil,
            ttl: Int? = nil,
            priority: Int? = nil,
            id: String? = nil,
            createdAt: Date? = nil,
            systemRecord: Bool? = nil
        ) {
            self.updatedAt = updatedAt
            self.content = content
            self.name = name
            self.type = type
            self.ttl = ttl
            self.priority = priority
            self.id = id
            self.createdAt = createdAt
            self.systemRecord = systemRecord
        }

        init(data: Payload, client _: Http.Client) {
            updatedAt = data.updatedAt
            content = data.content
            name = data.name
            type = data.type
            ttl = data.ttl
            priority = data.priority
            id = data.id
            createdAt = data.createdAt
            systemRecord = data.systemRecord
        }
    }
}

public extension Exoscale.Record {
    enum RecordType: Exoscale.ExtensibleEnum {
        case ns
        case caa
        case naptr
        case pool
        case a
        case hinfo
        case cname
        case soa
        case sshfp
        case srv
        case aaaa
        case mx
        case txt
        case alias
        case url
        case spf
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .ns,
            .caa,
            .naptr,
            .pool,
            .a,
            .hinfo,
            .cname,
            .soa,
            .sshfp,
            .srv,
            .aaaa,
            .mx,
            .txt,
            .alias,
            .url,
            .spf
        ]

        public var rawValue: String {
            switch self {
            case .ns: "NS"
            case .caa: "CAA"
            case .naptr: "NAPTR"
            case .pool: "POOL"
            case .a: "A"
            case .hinfo: "HINFO"
            case .cname: "CNAME"
            case .soa: "SOA"
            case .sshfp: "SSHFP"
            case .srv: "SRV"
            case .aaaa: "AAAA"
            case .mx: "MX"
            case .txt: "TXT"
            case .alias: "ALIAS"
            case .url: "URL"
            case .spf: "SPF"
            case let .unknown(value): value
            }
        }
    }
}
