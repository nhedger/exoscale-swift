import Foundation

public extension Exoscale {
    /// An OpenSearch service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct OpenSearchService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// The largest number of indices kept. Older ones are deleted.
        public let maxIndexCount: Int?
        /// Whether index refresh intervals are kept as set, instead of being managed.
        public let keepIndexRefreshInterval: Bool?
        /// Index patterns with their own maximum index count.
        public let indexPatterns: [IndexPattern]?
        /// The template new indices are created with.
        public let indexTemplate: IndexTemplate?
        /// OpenSearch Dashboards' configuration.
        public let dashboards: Dashboards?
        /// OpenSearch settings.
        public let opensearchSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            maxIndexCount: Int? = nil,
            keepIndexRefreshInterval: Bool? = nil,
            indexPatterns: [IndexPattern]? = nil,
            indexTemplate: IndexTemplate? = nil,
            dashboards: Dashboards? = nil,
            opensearchSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.maxIndexCount = maxIndexCount
            self.keepIndexRefreshInterval = keepIndexRefreshInterval
            self.indexPatterns = indexPatterns
            self.indexTemplate = indexTemplate
            self.dashboards = dashboards
            self.opensearchSettings = opensearchSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case maxIndexCount = "max-index-count"
            case keepIndexRefreshInterval = "keep-index-refresh-interval"
            case indexPatterns = "index-patterns"
            case indexTemplate = "index-template"
            case dashboards = "opensearch-dashboards"
            case opensearchSettings = "opensearch-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            maxIndexCount = try container.decodeIfPresent(Int.self, forKey: .maxIndexCount)
            keepIndexRefreshInterval = try container.decodeIfPresent(Bool.self, forKey: .keepIndexRefreshInterval)
            indexPatterns = try container.decodeIfPresent([IndexPattern].self, forKey: .indexPatterns)
            indexTemplate = try container.decodeIfPresent(IndexTemplate.self, forKey: .indexTemplate)
            dashboards = try container.decodeIfPresent(Dashboards.self, forKey: .dashboards)
            opensearchSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .opensearchSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(maxIndexCount, forKey: .maxIndexCount)
            try container.encodeIfPresent(keepIndexRefreshInterval, forKey: .keepIndexRefreshInterval)
            try container.encodeIfPresent(indexPatterns, forKey: .indexPatterns)
            try container.encodeIfPresent(indexTemplate, forKey: .indexTemplate)
            try container.encodeIfPresent(dashboards, forKey: .dashboards)
            try container.encodeIfPresent(opensearchSettings, forKey: .opensearchSettings)
        }
    }
}

public extension Exoscale.OpenSearchService {
    /// How to connect to an OpenSearch service.
    struct ConnectionInfo: Hashable, Codable, Sendable {
        /// The service's URIs.
        public let uri: [String]?
        /// The primary user's name.
        public let username: String?
        /// The primary user's password.
        public let password: String?
        /// The OpenSearch Dashboards URI.
        public let dashboardURI: String?

        /// Creates connection details, for example for previews and tests.
        public init(
            uri: [String]? = nil,
            username: String? = nil,
            password: String? = nil,
            dashboardURI: String? = nil
        ) {
            self.uri = uri
            self.username = username
            self.password = password
            self.dashboardURI = dashboardURI
        }

        enum CodingKeys: String, CodingKey {
            case uri, username, password
            case dashboardURI = "dashboard-uri"
        }
    }

    /// An index pattern with its own maximum index count.
    struct IndexPattern: Hashable, Codable, Sendable {
        /// The pattern, such as `logs-*`.
        public let pattern: String?
        /// The largest number of matching indices kept.
        public let maxIndexCount: Int?
        /// Which indices are deleted first: `alphabetical` or `creation_date`.
        public let sortingAlgorithm: String?

        /// Creates an index pattern.
        public init(pattern: String? = nil, maxIndexCount: Int? = nil, sortingAlgorithm: String? = nil) {
            self.pattern = pattern
            self.maxIndexCount = maxIndexCount
            self.sortingAlgorithm = sortingAlgorithm
        }

        enum CodingKeys: String, CodingKey {
            case pattern
            case maxIndexCount = "max-index-count"
            case sortingAlgorithm = "sorting-algorithm"
        }
    }

    /// The template new indices are created with.
    struct IndexTemplate: Hashable, Codable, Sendable {
        /// The number of shards.
        public let numberOfShards: Int?
        /// The number of replicas.
        public let numberOfReplicas: Int?
        /// The largest number of nested objects in a document.
        public let mappingNestedObjectsLimit: Int?

        /// Creates an index template.
        public init(numberOfShards: Int? = nil, numberOfReplicas: Int? = nil, mappingNestedObjectsLimit: Int? = nil) {
            self.numberOfShards = numberOfShards
            self.numberOfReplicas = numberOfReplicas
            self.mappingNestedObjectsLimit = mappingNestedObjectsLimit
        }

        enum CodingKeys: String, CodingKey {
            case numberOfShards = "number-of-shards"
            case numberOfReplicas = "number-of-replicas"
            case mappingNestedObjectsLimit = "mapping-nested-objects-limit"
        }
    }

    /// OpenSearch Dashboards' configuration.
    struct Dashboards: Hashable, Codable, Sendable {
        /// Whether OpenSearch Dashboards is enabled.
        public let enabled: Bool?
        /// The memory limit of its Node.js process, in MB.
        public let maxOldSpaceSize: Int?
        /// How long it waits for OpenSearch, in milliseconds.
        public let requestTimeout: Int?

        /// Creates a configuration.
        public init(enabled: Bool? = nil, maxOldSpaceSize: Int? = nil, requestTimeout: Int? = nil) {
            self.enabled = enabled
            self.maxOldSpaceSize = maxOldSpaceSize
            self.requestTimeout = requestTimeout
        }

        enum CodingKeys: String, CodingKey {
            case enabled
            case maxOldSpaceSize = "max-old-space-size"
            case requestTimeout = "opensearch-request-timeout"
        }
    }

    /// An OpenSearch service's access control.
    struct ACLConfig: Hashable, Codable, Sendable {
        /// Whether access control is enforced.
        public let aclEnabled: Bool?
        /// Whether rules also apply to document-level APIs, such as `_mget`.
        public let extendedACLEnabled: Bool?
        /// Each user's rules.
        public let acls: [UserACL]?

        /// Creates an access control configuration.
        public init(aclEnabled: Bool? = nil, extendedACLEnabled: Bool? = nil, acls: [UserACL]? = nil) {
            self.aclEnabled = aclEnabled
            self.extendedACLEnabled = extendedACLEnabled
            self.acls = acls
        }

        enum CodingKeys: String, CodingKey {
            case acls
            case aclEnabled = "acl-enabled"
            case extendedACLEnabled = "extended-acl-enabled"
        }

        /// A user's access rules.
        public struct UserACL: Hashable, Codable, Sendable {
            /// The user pattern the rules apply to.
            public let username: String?
            /// The rules.
            public let rules: [Rule]?

            /// Creates a user's rules.
            public init(username: String? = nil, rules: [Rule]? = nil) {
                self.username = username
                self.rules = rules
            }
        }

        /// What a user may do with matching indices.
        public struct Rule: Hashable, Codable, Sendable {
            /// The index pattern.
            public let index: String
            /// The permission: `admin`, `read`, `readwrite`, `write` or `deny`.
            public let permission: String?

            /// Creates a rule.
            public init(index: String, permission: String? = nil) {
                self.index = index
                self.permission = permission
            }
        }
    }
}
