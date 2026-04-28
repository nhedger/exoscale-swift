public extension Exoscale.DBaaS.Grafana {
    /// Grafana service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: String?
            public let username: String?
            public let password: String?
        }

        public struct User: Codable, Sendable {
            public let type: String?
            public let username: String?
            public let password: String?
        }

        public let description: String?
        public let updatedAt: String?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let type: String?
        public let state: String?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let grafanaSettings: [String: Exoscale.JSONValue]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: String?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case description
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case type
            case state
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case grafanaSettings = "grafana-settings"
            case maintenance
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case version
            case createdAt = "created-at"
            case plan
            case users
        }
    }

    /// Grafana user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    /// Grafana settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let grafana: Exoscale.DBaaS.SettingsSchema?
    }
}

public extension Exoscale.DBaaS.Kafka {
    /// Kafka authentication methods.
    struct AuthenticationMethods: Codable, Sendable {
        public let certificate: Bool?
        public let sasl: Bool?

        public init(certificate: Bool? = nil, sasl: Bool? = nil) {
            self.certificate = certificate
            self.sasl = sasl
        }
    }

    /// Kafka service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let nodes: [String]?
            public let accessCert: String?
            public let accessKey: String?
            public let connectURI: String?
            public let restURI: String?
            public let registryURI: String?

            enum CodingKeys: String, CodingKey {
                case nodes
                case accessCert = "access-cert"
                case accessKey = "access-key"
                case connectURI = "connect-uri"
                case restURI = "rest-uri"
                case registryURI = "registry-uri"
            }
        }

        public struct User: Codable, Sendable {
            public let type: String?
            public let username: String?
            public let password: String?
            public let accessCert: String?
            public let accessCertExpiry: String?
            public let accessKey: String?

            enum CodingKeys: String, CodingKey {
                case type
                case username
                case password
                case accessCert = "access-cert"
                case accessCertExpiry = "access-cert-expiry"
                case accessKey = "access-key"
            }
        }

        public let updatedAt: String?
        public let authenticationMethods: AuthenticationMethods?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let kafkaRestEnabled: Bool?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let kafkaConnectEnabled: Bool?
        public let type: String?
        public let state: String?
        public let ipFilter: [String]?
        public let schemaRegistrySettings: [String: Exoscale.JSONValue]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let kafkaRestSettings: [String: Exoscale.JSONValue]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let kafkaConnectSettings: [String: Exoscale.JSONValue]?
        public let components: [Exoscale.DBaaS.Component]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let kafkaSettings: [String: Exoscale.JSONValue]?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let schemaRegistryEnabled: Bool?
        public let version: String?
        public let createdAt: String?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case authenticationMethods = "authentication-methods"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case kafkaRestEnabled = "kafka-rest-enabled"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case kafkaConnectEnabled = "kafka-connect-enabled"
            case type
            case state
            case ipFilter = "ip-filter"
            case schemaRegistrySettings = "schema-registry-settings"
            case backups
            case kafkaRestSettings = "kafka-rest-settings"
            case terminationProtection = "termination-protection"
            case notifications
            case kafkaConnectSettings = "kafka-connect-settings"
            case components
            case maintenance
            case kafkaSettings = "kafka-settings"
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case schemaRegistryEnabled = "schema-registry-enabled"
            case version
            case createdAt = "created-at"
            case plan
            case users
        }
    }

    /// Kafka user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
        public let accessCert: String?
        public let accessCertExpiry: String?
        public let accessKey: String?

        enum CodingKeys: String, CodingKey {
            case username
            case password
            case accessCert = "access-cert"
            case accessCertExpiry = "access-cert-expiry"
            case accessKey = "access-key"
        }
    }

    /// Kafka Connect user credentials returned by the API.
    struct ConnectUserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    enum TopicACLPermission: String, Codable, Sendable {
        case admin
        case read
        case readwrite
        case write
    }

    enum SchemaRegistryACLPermission: String, Codable, Sendable {
        case read = "schema_registry_read"
        case write = "schema_registry_write"
    }

    /// Kafka topic ACL entry.
    struct TopicACLEntry: Codable, Sendable {
        public let id: String?
        public let username: String
        public let topic: String
        public let permission: TopicACLPermission

        public init(id: String? = nil, username: String, topic: String, permission: TopicACLPermission) {
            self.id = id
            self.username = username
            self.topic = topic
            self.permission = permission
        }
    }

    /// Kafka Schema Registry ACL entry.
    struct SchemaRegistryACLEntry: Codable, Sendable {
        public let id: String?
        public let username: String
        public let resource: String
        public let permission: SchemaRegistryACLPermission

        public init(id: String? = nil, username: String, resource: String, permission: SchemaRegistryACLPermission) {
            self.id = id
            self.username = username
            self.resource = resource
            self.permission = permission
        }
    }

    /// Kafka ACL configuration returned by the API.
    struct ACLConfig: Codable, Sendable {
        public let topicACL: [TopicACLEntry]?
        public let schemaRegistryACL: [SchemaRegistryACLEntry]?

        enum CodingKeys: String, CodingKey {
            case topicACL = "topic-acl"
            case schemaRegistryACL = "schema-registry-acl"
        }
    }

    /// Kafka settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let kafka: Exoscale.DBaaS.SettingsSchema?
        public let kafkaConnect: Exoscale.DBaaS.SettingsSchema?
        public let kafkaRest: Exoscale.DBaaS.SettingsSchema?
        public let schemaRegistry: Exoscale.DBaaS.SettingsSchema?

        enum CodingKeys: String, CodingKey {
            case kafka
            case kafkaConnect = "kafka-connect"
            case kafkaRest = "kafka-rest"
            case schemaRegistry = "schema-registry"
        }
    }
}

public extension Exoscale.DBaaS.MySQL {
    enum AuthenticationPlugin: String, Codable, Sendable {
        case cachingSHA2Password = "caching_sha2_password"
        case mysqlNativePassword = "mysql_native_password"
    }

    /// MySQL service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: [String]?
            public let params: [[String: String]]?
            public let standby: [String]?
        }

        public struct User: Codable, Sendable {
            public let type: String?
            public let username: String?
            public let password: String?
            public let authentication: String?
        }

        public let updatedAt: String?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let backupSchedule: Exoscale.DBaaS.BackupSchedule?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let type: String?
        public let state: String?
        public let databases: [String]?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let mysqlSettings: [String: Exoscale.JSONValue]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: String?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case backupSchedule = "backup-schedule"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case type
            case state
            case databases
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case mysqlSettings = "mysql-settings"
            case maintenance
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case version
            case createdAt = "created-at"
            case plan
            case users
        }
    }

    /// MySQL user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    /// MySQL settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let mysql: Exoscale.DBaaS.SettingsSchema?
    }
}

public extension Exoscale.DBaaS.OpenSearch {
    /// OpenSearch index retention pattern.
    struct IndexPattern: Codable, Sendable {
        public let maxIndexCount: Int?
        public let sortingAlgorithm: String?
        public let pattern: String?

        public init(maxIndexCount: Int? = nil, sortingAlgorithm: String? = nil, pattern: String? = nil) {
            self.maxIndexCount = maxIndexCount
            self.sortingAlgorithm = sortingAlgorithm
            self.pattern = pattern
        }

        enum CodingKeys: String, CodingKey {
            case maxIndexCount = "max-index-count"
            case sortingAlgorithm = "sorting-algorithm"
            case pattern
        }
    }

    /// OpenSearch index template.
    struct IndexTemplate: Codable, Sendable {
        public let mappingNestedObjectsLimit: Int?
        public let numberOfReplicas: Int?
        public let numberOfShards: Int?

        public init(mappingNestedObjectsLimit: Int? = nil, numberOfReplicas: Int? = nil, numberOfShards: Int? = nil) {
            self.mappingNestedObjectsLimit = mappingNestedObjectsLimit
            self.numberOfReplicas = numberOfReplicas
            self.numberOfShards = numberOfShards
        }

        enum CodingKeys: String, CodingKey {
            case mappingNestedObjectsLimit = "mapping-nested-objects-limit"
            case numberOfReplicas = "number-of-replicas"
            case numberOfShards = "number-of-shards"
        }
    }

    /// OpenSearch Dashboards settings.
    struct Dashboards: Codable, Sendable {
        public let opensearchRequestTimeout: Int?
        public let enabled: Bool?
        public let maxOldSpaceSize: Int?

        public init(opensearchRequestTimeout: Int? = nil, enabled: Bool? = nil, maxOldSpaceSize: Int? = nil) {
            self.opensearchRequestTimeout = opensearchRequestTimeout
            self.enabled = enabled
            self.maxOldSpaceSize = maxOldSpaceSize
        }

        enum CodingKeys: String, CodingKey {
            case opensearchRequestTimeout = "opensearch-request-timeout"
            case enabled
            case maxOldSpaceSize = "max-old-space-size"
        }
    }

    /// OpenSearch service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: [String]?
            public let username: String?
            public let password: String?
            public let dashboardURI: String?

            enum CodingKeys: String, CodingKey {
                case uri
                case username
                case password
                case dashboardURI = "dashboard-uri"
            }
        }

        public struct User: Codable, Sendable {
            public let type: String?
            public let username: String?
            public let password: String?
        }

        public let description: String?
        public let maxIndexCount: Int?
        public let updatedAt: String?
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
        public let createdAt: String?
        public let plan: String?
        public let opensearchDashboards: Dashboards?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case description
            case maxIndexCount = "max-index-count"
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case keepIndexRefreshInterval = "keep-index-refresh-interval"
            case type
            case state
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case indexPatterns = "index-patterns"
            case maintenance
            case indexTemplate = "index-template"
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case opensearchSettings = "opensearch-settings"
            case uriParams = "uri-params"
            case version
            case createdAt = "created-at"
            case plan
            case opensearchDashboards = "opensearch-dashboards"
            case users
        }
    }

    /// OpenSearch user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    enum ACLPermission: String, Codable, Sendable {
        case admin
        case read
        case deny
        case readwrite
        case write
    }

    /// OpenSearch ACL configuration.
    struct ACLConfig: Codable, Sendable {
        public struct ACL: Codable, Sendable {
            public struct Rule: Codable, Sendable {
                public let index: String?
                public let permission: ACLPermission?

                public init(index: String? = nil, permission: ACLPermission? = nil) {
                    self.index = index
                    self.permission = permission
                }
            }

            public let username: String?
            public let rules: [Rule]?

            public init(username: String? = nil, rules: [Rule]? = nil) {
                self.username = username
                self.rules = rules
            }
        }

        public let acls: [ACL]?
        public let aclEnabled: Bool?
        public let extendedACLEnabled: Bool?

        public init(acls: [ACL]? = nil, aclEnabled: Bool? = nil, extendedACLEnabled: Bool? = nil) {
            self.acls = acls
            self.aclEnabled = aclEnabled
            self.extendedACLEnabled = extendedACLEnabled
        }

        enum CodingKeys: String, CodingKey {
            case acls
            case aclEnabled = "acl-enabled"
            case extendedACLEnabled = "extended-acl-enabled"
        }
    }

    /// OpenSearch settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let opensearch: Exoscale.DBaaS.SettingsSchema?
    }
}

public extension Exoscale.DBaaS.Thanos {
    /// Thanos service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let queryFrontendURI: String?
            public let queryURI: String?
            public let receiverRemoteWriteURI: String?
            public let rulerURI: String?

            enum CodingKeys: String, CodingKey {
                case queryFrontendURI = "query-frontend-uri"
                case queryURI = "query-uri"
                case receiverRemoteWriteURI = "receiver-remote-write-uri"
                case rulerURI = "ruler-uri"
            }
        }

        public struct User: Codable, Sendable {
            public let type: String?
            public let username: String?
            public let password: String?
        }

        public let updatedAt: String?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let type: String?
        public let state: String?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let thanosSettings: [String: Exoscale.JSONValue]?
        public let createdAt: String?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case type
            case state
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case maintenance
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case thanosSettings = "thanos-settings"
            case createdAt = "created-at"
            case plan
            case users
        }
    }

    /// Thanos user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    /// Thanos settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let thanos: Exoscale.DBaaS.SettingsSchema?
    }
}

public extension Exoscale.DBaaS.Valkey {
    /// Valkey user ACL configuration.
    struct AccessControl: Codable, Sendable {
        public let categories: [String]?
        public let channels: [String]?
        public let commands: [String]?
        public let keys: [String]?

        public init(categories: [String]? = nil, channels: [String]? = nil, commands: [String]? = nil, keys: [String]? = nil) {
            self.categories = categories
            self.channels = channels
            self.commands = commands
            self.keys = keys
        }
    }

    /// Valkey user returned by the API.
    struct User: Codable, Sendable {
        public let username: String?
        public let type: String?
        public let accessControl: AccessControl?

        enum CodingKeys: String, CodingKey {
            case username
            case type
            case accessControl = "access-control"
        }
    }

    /// Valkey service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: [String]?
            public let password: String?
            public let slave: [String]?
        }

        public let updatedAt: String?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let type: String?
        public let state: String?
        public let valkeySettings: [String: Exoscale.JSONValue]?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: String?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case type
            case state
            case valkeySettings = "valkey-settings"
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case maintenance
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case version
            case createdAt = "created-at"
            case plan
            case users
        }
    }

    /// Valkey user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    /// Valkey settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public let valkey: Exoscale.DBaaS.SettingsSchema?
    }
}
