import Foundation

public extension Exoscale.DBaaS.Kafka {
    /// Kafka authentication methods.
    struct AuthenticationMethods: Codable, Hashable, Sendable {
        public let certificate: Bool?
        public let sasl: Bool?

        public init(certificate: Bool? = nil, sasl: Bool? = nil) {
            self.certificate = certificate
            self.sasl = sasl
        }
    }

    /// Kafka service returned by the API.
    struct Service: Hashable, Sendable {
        public let updatedAt: Date?
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
        public let createdAt: Date?
        public let plan: String?
        public let users: [User]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            authenticationMethods: AuthenticationMethods? = nil,
            nodeCount: Int? = nil,
            connectionInfo: ConnectionInfo? = nil,
            nodeCPUCount: Int? = nil,
            kafkaRestEnabled: Bool? = nil,
            prometheusURI: Exoscale.DBaaS.PrometheusURI? = nil,
            integrations: [Exoscale.DBaaS.Integration]? = nil,
            zone: String? = nil,
            nodeStates: [Exoscale.DBaaS.NodeState]? = nil,
            name: String? = nil,
            kafkaConnectEnabled: Bool? = nil,
            type: String? = nil,
            state: String? = nil,
            ipFilter: [String]? = nil,
            schemaRegistrySettings: [String: Exoscale.JSONValue]? = nil,
            backups: [Exoscale.DBaaS.Backup]? = nil,
            kafkaRestSettings: [String: Exoscale.JSONValue]? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Exoscale.DBaaS.Notification]? = nil,
            kafkaConnectSettings: [String: Exoscale.JSONValue]? = nil,
            components: [Exoscale.DBaaS.Component]? = nil,
            maintenance: Exoscale.DBaaS.Maintenance? = nil,
            kafkaSettings: [String: Exoscale.JSONValue]? = nil,
            diskSize: Int? = nil,
            nodeMemory: Int? = nil,
            uri: String? = nil,
            uriParams: [String: Exoscale.JSONValue]? = nil,
            schemaRegistryEnabled: Bool? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            plan: String? = nil,
            users: [User]? = nil
        ) {
            self.updatedAt = updatedAt
            self.authenticationMethods = authenticationMethods
            self.nodeCount = nodeCount
            self.connectionInfo = connectionInfo
            self.nodeCPUCount = nodeCPUCount
            self.kafkaRestEnabled = kafkaRestEnabled
            self.prometheusURI = prometheusURI
            self.integrations = integrations
            self.zone = zone
            self.nodeStates = nodeStates
            self.name = name
            self.kafkaConnectEnabled = kafkaConnectEnabled
            self.type = type
            self.state = state
            self.ipFilter = ipFilter
            self.schemaRegistrySettings = schemaRegistrySettings
            self.backups = backups
            self.kafkaRestSettings = kafkaRestSettings
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.kafkaConnectSettings = kafkaConnectSettings
            self.components = components
            self.maintenance = maintenance
            self.kafkaSettings = kafkaSettings
            self.diskSize = diskSize
            self.nodeMemory = nodeMemory
            self.uri = uri
            self.uriParams = uriParams
            self.schemaRegistryEnabled = schemaRegistryEnabled
            self.version = version
            self.createdAt = createdAt
            self.plan = plan
            self.users = users
        }

        init(data: Payload, client: Http.Client) {
            updatedAt = data.updatedAt
            authenticationMethods = data.authenticationMethods
            nodeCount = data.nodeCount
            connectionInfo = data.connectionInfo
            nodeCPUCount = data.nodeCPUCount
            kafkaRestEnabled = data.kafkaRestEnabled
            prometheusURI = data.prometheusURI.map { Exoscale.DBaaS.PrometheusURI(data: $0, client: client) }
            integrations = data.integrations.map { $0.map { Exoscale.DBaaS.Integration(data: $0, client: client) } }
            zone = data.zone
            nodeStates = data.nodeStates.map { $0.map { Exoscale.DBaaS.NodeState(data: $0, client: client) } }
            name = data.name
            kafkaConnectEnabled = data.kafkaConnectEnabled
            type = data.type
            state = data.state
            ipFilter = data.ipFilter
            schemaRegistrySettings = data.schemaRegistrySettings
            backups = data.backups.map { $0.map { Exoscale.DBaaS.Backup(data: $0, client: client) } }
            kafkaRestSettings = data.kafkaRestSettings
            terminationProtection = data.terminationProtection
            notifications = data.notifications.map { $0.map { Exoscale.DBaaS.Notification(data: $0, client: client) } }
            kafkaConnectSettings = data.kafkaConnectSettings
            components = data.components.map { $0.map { Exoscale.DBaaS.Component(data: $0, client: client) } }
            maintenance = data.maintenance
            kafkaSettings = data.kafkaSettings
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            uri = data.uri
            uriParams = data.uriParams
            schemaRegistryEnabled = data.schemaRegistryEnabled
            version = data.version
            createdAt = data.createdAt
            plan = data.plan
            users = data.users
        }
    }

    /// Kafka user credentials returned by the API.
    struct UserSecrets: Hashable, Sendable {
        public let username: String?
        public let password: String?
        public let accessCert: String?
        public let accessCertExpiry: Date?
        public let accessKey: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String? = nil,
            password: String? = nil,
            accessCert: String? = nil,
            accessCertExpiry: Date? = nil,
            accessKey: String? = nil
        ) {
            self.username = username
            self.password = password
            self.accessCert = accessCert
            self.accessCertExpiry = accessCertExpiry
            self.accessKey = accessKey
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            password = data.password
            accessCert = data.accessCert
            accessCertExpiry = data.accessCertExpiry
            accessKey = data.accessKey
        }
    }

    /// Kafka Connect user credentials returned by the API.
    struct ConnectUserSecrets: Hashable, Sendable {
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

    enum TopicACLPermission: Exoscale.ExtensibleEnum {
        case admin
        case read
        case readwrite
        case write
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.admin, .read, .readwrite, .write]

        public var rawValue: String {
            switch self {
            case .admin: "admin"
            case .read: "read"
            case .readwrite: "readwrite"
            case .write: "write"
            case let .unknown(value): value
            }
        }
    }

    enum SchemaRegistryACLPermission: Exoscale.ExtensibleEnum {
        case read
        case write
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.read, .write]

        public var rawValue: String {
            switch self {
            case .read: "schema_registry_read"
            case .write: "schema_registry_write"
            case let .unknown(value): value
            }
        }
    }

    /// Kafka topic ACL entry.
    struct TopicACLEntry: Codable, Hashable, Sendable {
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
    struct SchemaRegistryACLEntry: Codable, Hashable, Sendable {
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
    struct ACLConfig: Hashable, Sendable {
        public let topicACL: [TopicACLEntry]?
        public let schemaRegistryACL: [SchemaRegistryACLEntry]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            topicACL: [TopicACLEntry]? = nil,
            schemaRegistryACL: [SchemaRegistryACLEntry]? = nil
        ) {
            self.topicACL = topicACL
            self.schemaRegistryACL = schemaRegistryACL
        }

        init(data: Payload, client _: Http.Client) {
            topicACL = data.topicACL
            schemaRegistryACL = data.schemaRegistryACL
        }
    }

    /// Kafka settings schema returned by the API.
    struct Settings: Hashable, Sendable {
        public let kafka: Exoscale.DBaaS.SettingsSchema?
        public let kafkaConnect: Exoscale.DBaaS.SettingsSchema?
        public let kafkaRest: Exoscale.DBaaS.SettingsSchema?
        public let schemaRegistry: Exoscale.DBaaS.SettingsSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            kafka: Exoscale.DBaaS.SettingsSchema? = nil,
            kafkaConnect: Exoscale.DBaaS.SettingsSchema? = nil,
            kafkaRest: Exoscale.DBaaS.SettingsSchema? = nil,
            schemaRegistry: Exoscale.DBaaS.SettingsSchema? = nil
        ) {
            self.kafka = kafka
            self.kafkaConnect = kafkaConnect
            self.kafkaRest = kafkaRest
            self.schemaRegistry = schemaRegistry
        }

        init(data: Payload, client: Http.Client) {
            kafka = data.kafka.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
            kafkaConnect = data.kafkaConnect.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
            kafkaRest = data.kafkaRest.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
            schemaRegistry = data.schemaRegistry.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
        }
    }
}
