import Foundation

public extension Exoscale.DBaaS.OpenSearch {
    /// OpenSearch index retention pattern.
    struct IndexPattern: Codable, Hashable, Sendable {
        public let maxIndexCount: Int?
        public let sortingAlgorithm: String?
        public let pattern: String?

        public init(maxIndexCount: Int? = nil, sortingAlgorithm: String? = nil, pattern: String? = nil) {
            self.maxIndexCount = maxIndexCount
            self.sortingAlgorithm = sortingAlgorithm
            self.pattern = pattern
        }
    }

    /// OpenSearch index template.
    struct IndexTemplate: Codable, Hashable, Sendable {
        public let mappingNestedObjectsLimit: Int?
        public let numberOfReplicas: Int?
        public let numberOfShards: Int?

        public init(mappingNestedObjectsLimit: Int? = nil, numberOfReplicas: Int? = nil, numberOfShards: Int? = nil) {
            self.mappingNestedObjectsLimit = mappingNestedObjectsLimit
            self.numberOfReplicas = numberOfReplicas
            self.numberOfShards = numberOfShards
        }
    }

    /// OpenSearch Dashboards settings.
    struct Dashboards: Codable, Hashable, Sendable {
        public let opensearchRequestTimeout: Int?
        public let enabled: Bool?
        public let maxOldSpaceSize: Int?

        public init(opensearchRequestTimeout: Int? = nil, enabled: Bool? = nil, maxOldSpaceSize: Int? = nil) {
            self.opensearchRequestTimeout = opensearchRequestTimeout
            self.enabled = enabled
            self.maxOldSpaceSize = maxOldSpaceSize
        }
    }

    /// OpenSearch service returned by the API.
    struct Service: Hashable, Sendable {
        public let description: String?
        public let maxIndexCount: Int?
        public let updatedAt: Date?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let keepIndexRefreshInterval: Bool?
        public let type: String?
        public let state: String?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let indexPatterns: [IndexPattern]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let indexTemplate: IndexTemplate?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let opensearchSettings: [String: Exoscale.JSONValue]?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: Date?
        public let plan: String?
        public let opensearchDashboards: Dashboards?
        public let users: [User]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            maxIndexCount: Int? = nil,
            updatedAt: Date? = nil,
            nodeCount: Int? = nil,
            connectionInfo: ConnectionInfo? = nil,
            nodeCPUCount: Int? = nil,
            prometheusURI: Exoscale.DBaaS.PrometheusURI? = nil,
            integrations: [Exoscale.DBaaS.Integration]? = nil,
            zone: String? = nil,
            nodeStates: [Exoscale.DBaaS.NodeState]? = nil,
            name: String? = nil,
            keepIndexRefreshInterval: Bool? = nil,
            type: String? = nil,
            state: String? = nil,
            ipFilter: [String]? = nil,
            backups: [Exoscale.DBaaS.Backup]? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Exoscale.DBaaS.Notification]? = nil,
            components: [Exoscale.DBaaS.Component]? = nil,
            indexPatterns: [IndexPattern]? = nil,
            maintenance: Exoscale.DBaaS.Maintenance? = nil,
            indexTemplate: IndexTemplate? = nil,
            diskSize: Int? = nil,
            nodeMemory: Int? = nil,
            uri: String? = nil,
            opensearchSettings: [String: Exoscale.JSONValue]? = nil,
            uriParams: [String: Exoscale.JSONValue]? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            plan: String? = nil,
            opensearchDashboards: Dashboards? = nil,
            users: [User]? = nil
        ) {
            self.description = description
            self.maxIndexCount = maxIndexCount
            self.updatedAt = updatedAt
            self.nodeCount = nodeCount
            self.connectionInfo = connectionInfo
            self.nodeCPUCount = nodeCPUCount
            self.prometheusURI = prometheusURI
            self.integrations = integrations
            self.zone = zone
            self.nodeStates = nodeStates
            self.name = name
            self.keepIndexRefreshInterval = keepIndexRefreshInterval
            self.type = type
            self.state = state
            self.ipFilter = ipFilter
            self.backups = backups
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.components = components
            self.indexPatterns = indexPatterns
            self.maintenance = maintenance
            self.indexTemplate = indexTemplate
            self.diskSize = diskSize
            self.nodeMemory = nodeMemory
            self.uri = uri
            self.opensearchSettings = opensearchSettings
            self.uriParams = uriParams
            self.version = version
            self.createdAt = createdAt
            self.plan = plan
            self.opensearchDashboards = opensearchDashboards
            self.users = users
        }

        init(data: Payload, client: Http.Client) {
            description = data.description
            maxIndexCount = data.maxIndexCount
            updatedAt = data.updatedAt
            nodeCount = data.nodeCount
            connectionInfo = data.connectionInfo
            nodeCPUCount = data.nodeCPUCount
            prometheusURI = data.prometheusURI.map { Exoscale.DBaaS.PrometheusURI(data: $0, client: client) }
            integrations = data.integrations.map { $0.map { Exoscale.DBaaS.Integration(data: $0, client: client) } }
            zone = data.zone
            nodeStates = data.nodeStates.map { $0.map { Exoscale.DBaaS.NodeState(data: $0, client: client) } }
            name = data.name
            keepIndexRefreshInterval = data.keepIndexRefreshInterval
            type = data.type
            state = data.state
            ipFilter = data.ipFilter
            backups = data.backups.map { $0.map { Exoscale.DBaaS.Backup(data: $0, client: client) } }
            terminationProtection = data.terminationProtection
            notifications = data.notifications.map { $0.map { Exoscale.DBaaS.Notification(data: $0, client: client) } }
            components = data.components.map { $0.map { Exoscale.DBaaS.Component(data: $0, client: client) } }
            indexPatterns = data.indexPatterns
            maintenance = data.maintenance
            indexTemplate = data.indexTemplate
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            uri = data.uri
            opensearchSettings = data.opensearchSettings
            uriParams = data.uriParams
            version = data.version
            createdAt = data.createdAt
            plan = data.plan
            opensearchDashboards = data.opensearchDashboards
            users = data.users
        }
    }

    /// OpenSearch user credentials returned by the API.
    struct UserSecrets: Hashable, Sendable {
        public let username: String?
        public let password: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String? = nil,
            password: String? = nil
        ) {
            self.username = username
            self.password = password
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            password = data.password
        }
    }

    enum ACLPermission: Exoscale.ExtensibleEnum {
        case admin
        case read
        case deny
        case readwrite
        case write
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.admin, .read, .deny, .readwrite, .write]

        public var rawValue: String {
            switch self {
            case .admin: "admin"
            case .read: "read"
            case .deny: "deny"
            case .readwrite: "readwrite"
            case .write: "write"
            case let .unknown(value): value
            }
        }
    }

    /// OpenSearch ACL configuration.
    struct ACLConfig: Codable, Hashable, Sendable {
        public let acls: [ACL]?
        public let aclEnabled: Bool?
        public let extendedACLEnabled: Bool?

        public init(acls: [ACL]? = nil, aclEnabled: Bool? = nil, extendedACLEnabled: Bool? = nil) {
            self.acls = acls
            self.aclEnabled = aclEnabled
            self.extendedACLEnabled = extendedACLEnabled
        }
    }

    /// OpenSearch settings schema returned by the API.
    struct Settings: Hashable, Sendable {
        public let opensearch: Exoscale.DBaaS.SettingsSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            opensearch: Exoscale.DBaaS.SettingsSchema? = nil
        ) {
            self.opensearch = opensearch
        }

        init(data: Payload, client: Http.Client) {
            opensearch = data.opensearch.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
        }
    }
}

extension Exoscale.DBaaS.OpenSearch.IndexPattern {
    enum CodingKeys: String, CodingKey {
        case maxIndexCount = "max-index-count"
        case sortingAlgorithm = "sorting-algorithm"
        case pattern
    }
}

extension Exoscale.DBaaS.OpenSearch.IndexTemplate {
    enum CodingKeys: String, CodingKey {
        case mappingNestedObjectsLimit = "mapping-nested-objects-limit"
        case numberOfReplicas = "number-of-replicas"
        case numberOfShards = "number-of-shards"
    }
}

extension Exoscale.DBaaS.OpenSearch.Dashboards {
    enum CodingKeys: String, CodingKey {
        case opensearchRequestTimeout = "opensearch-request-timeout"
        case enabled
        case maxOldSpaceSize = "max-old-space-size"
    }
}

extension Exoscale.DBaaS.OpenSearch.Service.ConnectionInfo {
    enum CodingKeys: String, CodingKey {
        case uri
        case username
        case password
        case dashboardURI = "dashboard-uri"
    }
}

public extension Exoscale.DBaaS.OpenSearch.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let uri: [String]?
        public let username: String?
        public let password: String?
        public let dashboardURI: String?

        /// Creates a value from its properties, for example for previews and tests.
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
    }
}

public extension Exoscale.DBaaS.OpenSearch.Service {
    struct User: Codable, Hashable, Sendable {
        public let type: String?
        public let username: String?
        public let password: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: String? = nil,
            username: String? = nil,
            password: String? = nil
        ) {
            self.type = type
            self.username = username
            self.password = password
        }
    }
}

public extension Exoscale.DBaaS.OpenSearch.ACLConfig.ACL {
    struct Rule: Codable, Hashable, Sendable {
        public let index: String?
        public let permission: Exoscale.DBaaS.OpenSearch.ACLPermission?

        public init(index: String? = nil, permission: Exoscale.DBaaS.OpenSearch.ACLPermission? = nil) {
            self.index = index
            self.permission = permission
        }
    }
}

public extension Exoscale.DBaaS.OpenSearch.ACLConfig {
    struct ACL: Codable, Hashable, Sendable {
        public let username: String?
        public let rules: [Rule]?

        public init(username: String? = nil, rules: [Rule]? = nil) {
            self.username = username
            self.rules = rules
        }
    }
}

extension Exoscale.DBaaS.OpenSearch.ACLConfig {
    enum CodingKeys: String, CodingKey {
        case acls
        case aclEnabled = "acl-enabled"
        case extendedACLEnabled = "extended-acl-enabled"
    }
}
