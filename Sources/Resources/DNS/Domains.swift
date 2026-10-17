import Foundation

public extension Exoscale {
    /// A DNS domain hosted by Exoscale.
    struct Domain: Hashable, Codable, Sendable {
        /// The domain's identifier.
        public let id: String
        /// The domain name, with international characters as Unicode.
        public let unicodeName: String?
        /// When the domain was added.
        public let createdAt: Date?

        /// Creates a domain, for example for previews and tests.
        public init(id: String, unicodeName: String? = nil, createdAt: Date? = nil) {
            self.id = id
            self.unicodeName = unicodeName
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id
            case unicodeName = "unicode-name"
            case createdAt = "created-at"
        }
    }

    /// A record of a DNS domain.
    struct DomainRecord: Hashable, Codable, Sendable {
        /// The record's identifier.
        public let id: String
        /// The record's name within the domain, empty for the domain itself.
        public let name: String?
        /// The record's type.
        public let type: RecordType?
        /// The record's value.
        public let content: String?
        /// How long resolvers may cache the record, in seconds.
        public let ttl: Int?
        /// The record's priority, for types that have one such as MX and SRV.
        public let priority: Int?
        /// Whether Exoscale manages the record, such as the domain's NS and SOA records.
        public let isSystemRecord: Bool?
        /// When the record was created.
        public let createdAt: Date?
        /// When the record was last changed.
        public let updatedAt: Date?

        /// Creates a record, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            type: RecordType? = nil,
            content: String? = nil,
            ttl: Int? = nil,
            priority: Int? = nil,
            isSystemRecord: Bool? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.content = content
            self.ttl = ttl
            self.priority = priority
            self.isSystemRecord = isSystemRecord
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, type, content, ttl, priority
            case isSystemRecord = "system-record"
            case createdAt = "created-at"
            case updatedAt = "updated-at"
        }

        /// A DNS record type.
        public struct RecordType: RawRepresentable, Hashable, Codable, Sendable {
            /// The type as the API names it.
            public let rawValue: String

            /// Creates a type, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// IPv4 address.
            public static let a = RecordType(rawValue: "A")
            /// IPv6 address.
            public static let aaaa = RecordType(rawValue: "AAAA")
            /// Alias of another name, allowed at the domain apex.
            public static let alias = RecordType(rawValue: "ALIAS")
            /// Certification authority authorization.
            public static let caa = RecordType(rawValue: "CAA")
            /// Canonical name.
            public static let cname = RecordType(rawValue: "CNAME")
            /// Host information.
            public static let hinfo = RecordType(rawValue: "HINFO")
            /// Mail exchanger.
            public static let mx = RecordType(rawValue: "MX")
            /// Naming authority pointer.
            public static let naptr = RecordType(rawValue: "NAPTR")
            /// Name server.
            public static let ns = RecordType(rawValue: "NS")
            /// A pool of addresses.
            public static let pool = RecordType(rawValue: "POOL")
            /// Start of authority.
            public static let soa = RecordType(rawValue: "SOA")
            /// Sender policy framework.
            public static let spf = RecordType(rawValue: "SPF")
            /// Service locator.
            public static let srv = RecordType(rawValue: "SRV")
            /// SSH public key fingerprint.
            public static let sshfp = RecordType(rawValue: "SSHFP")
            /// Text.
            public static let txt = RecordType(rawValue: "TXT")
            /// URL redirect.
            public static let url = RecordType(rawValue: "URL")
        }
    }

    /// DNS domains hosted by Exoscale.
    struct Domains: Sendable {
        let client: HTTPClient

        /// Lists the domains.
        public func list() async throws -> [Domain] {
            try await client.send(.get, "/dns-domain", unwrapping: "dns-domains")
        }

        /// Retrieves a domain.
        public func get(id: String) async throws -> Domain {
            try await client.send(.get, "/dns-domain/\(id)")
        }

        /// Adds a domain.
        ///
        /// - Parameter name: The domain name, such as `example.com`.
        public func create(name: String) async throws -> Operation {
            try await client.send(.post, "/dns-domain", body: ["unicode-name": name] as JSONBody)
        }

        /// Deletes a domain and its records.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/dns-domain/\(id)")
        }

        /// Retrieves a domain's records as a BIND zone file.
        public func zoneFile(id: String) async throws -> String {
            let response = try await client.send(.get, "/dns-domain/\(id)/zone", as: ZoneFile.self)
            guard let zoneFile = response.zoneFile else {
                throw ClientError.invalidResponse
            }
            return zoneFile
        }

        /// The records of a domain.
        public func records(in domainID: String) -> DomainRecords {
            DomainRecords(client: client, domainID: domainID)
        }
    }

    /// The records of one DNS domain.
    struct DomainRecords: Sendable {
        let client: HTTPClient
        /// The domain's identifier.
        public let domainID: String

        /// Lists the records.
        public func list() async throws -> [DomainRecord] {
            try await client.send(.get, "/dns-domain/\(domainID)/record", unwrapping: "dns-domain-records")
        }

        /// Retrieves a record.
        public func get(id: String) async throws -> DomainRecord {
            try await client.send(.get, "/dns-domain/\(domainID)/record/\(id)")
        }

        /// Creates a record.
        ///
        /// - Parameters:
        ///   - name: The name within the domain, such as `www`, or an empty string for the domain itself.
        ///   - type: The record type.
        ///   - content: The record's value.
        ///   - ttl: How long resolvers may cache the record, in seconds.
        ///   - priority: The priority, for types that have one such as MX and SRV.
        public func create(
            name: String,
            type: DomainRecord.RecordType,
            content: String,
            ttl: Int? = nil,
            priority: Int? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dns-domain/\(domainID)/record", body: [
                "name": name,
                "type": type,
                "content": content,
                "ttl": ttl,
                "priority": priority
            ] as JSONBody)
        }

        /// Updates a record. Only the values passed are changed.
        public func update(
            id: String,
            name: String? = nil,
            content: String? = nil,
            ttl: Int? = nil,
            priority: Int? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/dns-domain/\(domainID)/record/\(id)", body: [
                "name": name,
                "content": content,
                "ttl": ttl,
                "priority": priority
            ] as JSONBody)
        }

        /// Deletes a record.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/dns-domain/\(domainID)/record/\(id)")
        }
    }
}

private struct ZoneFile: Decodable {
    let zoneFile: String?

    enum CodingKeys: String, CodingKey {
        case zoneFile = "zone-file"
    }
}
