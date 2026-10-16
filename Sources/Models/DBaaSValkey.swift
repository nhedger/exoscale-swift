import Foundation

public extension Exoscale.DBaaS.Valkey {
    /// Valkey user ACL configuration.
    struct AccessControl: Codable, Hashable, Sendable {
        public let categories: [String]?
        public let channels: [String]?
        public let commands: [String]?
        public let keys: [String]?

        public init(
            categories: [String]? = nil,
            channels: [String]? = nil,
            commands: [String]? = nil,
            keys: [String]? = nil
        ) {
            self.categories = categories
            self.channels = channels
            self.commands = commands
            self.keys = keys
        }
    }

    /// Valkey user returned by the API.
    struct User: Hashable, Sendable {
        public let username: String?
        public let type: String?
        public let accessControl: AccessControl?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String? = nil,
            type: String? = nil,
            accessControl: AccessControl? = nil
        ) {
            self.username = username
            self.type = type
            self.accessControl = accessControl
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            type = data.type
            accessControl = data.accessControl
        }
    }

    /// Valkey service returned by the API.
    struct Service: Hashable, Sendable {
        public let updatedAt: Date?
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
        public let createdAt: Date?
        public let plan: String?
        public let users: [User]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            nodeCount: Int? = nil,
            connectionInfo: ConnectionInfo? = nil,
            nodeCPUCount: Int? = nil,
            prometheusURI: Exoscale.DBaaS.PrometheusURI? = nil,
            integrations: [Exoscale.DBaaS.Integration]? = nil,
            zone: String? = nil,
            nodeStates: [Exoscale.DBaaS.NodeState]? = nil,
            name: String? = nil,
            type: String? = nil,
            state: String? = nil,
            valkeySettings: [String: Exoscale.JSONValue]? = nil,
            ipFilter: [String]? = nil,
            backups: [Exoscale.DBaaS.Backup]? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Exoscale.DBaaS.Notification]? = nil,
            components: [Exoscale.DBaaS.Component]? = nil,
            maintenance: Exoscale.DBaaS.Maintenance? = nil,
            diskSize: Int? = nil,
            nodeMemory: Int? = nil,
            uri: String? = nil,
            uriParams: [String: Exoscale.JSONValue]? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            plan: String? = nil,
            users: [User]? = nil
        ) {
            self.updatedAt = updatedAt
            self.nodeCount = nodeCount
            self.connectionInfo = connectionInfo
            self.nodeCPUCount = nodeCPUCount
            self.prometheusURI = prometheusURI
            self.integrations = integrations
            self.zone = zone
            self.nodeStates = nodeStates
            self.name = name
            self.type = type
            self.state = state
            self.valkeySettings = valkeySettings
            self.ipFilter = ipFilter
            self.backups = backups
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.components = components
            self.maintenance = maintenance
            self.diskSize = diskSize
            self.nodeMemory = nodeMemory
            self.uri = uri
            self.uriParams = uriParams
            self.version = version
            self.createdAt = createdAt
            self.plan = plan
            self.users = users
        }

        init(data: Payload, client: Http.Client) {
            updatedAt = data.updatedAt
            nodeCount = data.nodeCount
            connectionInfo = data.connectionInfo
            nodeCPUCount = data.nodeCPUCount
            prometheusURI = data.prometheusURI.map { Exoscale.DBaaS.PrometheusURI(data: $0, client: client) }
            integrations = data.integrations.map { $0.map { Exoscale.DBaaS.Integration(data: $0, client: client) } }
            zone = data.zone
            nodeStates = data.nodeStates.map { $0.map { Exoscale.DBaaS.NodeState(data: $0, client: client) } }
            name = data.name
            type = data.type
            state = data.state
            valkeySettings = data.valkeySettings
            ipFilter = data.ipFilter
            backups = data.backups.map { $0.map { Exoscale.DBaaS.Backup(data: $0, client: client) } }
            terminationProtection = data.terminationProtection
            notifications = data.notifications.map { $0.map { Exoscale.DBaaS.Notification(data: $0, client: client) } }
            components = data.components.map { $0.map { Exoscale.DBaaS.Component(data: $0, client: client) } }
            maintenance = data.maintenance
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            uri = data.uri
            uriParams = data.uriParams
            version = data.version
            createdAt = data.createdAt
            plan = data.plan
            users = data.users.map { $0.map { Exoscale.DBaaS.Valkey.User(data: $0, client: client) } }
        }
    }

    /// Valkey user credentials returned by the API.
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

    /// Valkey settings schema returned by the API.
    struct Settings: Hashable, Sendable {
        public let valkey: Exoscale.DBaaS.SettingsSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            valkey: Exoscale.DBaaS.SettingsSchema? = nil
        ) {
            self.valkey = valkey
        }

        init(data: Payload, client: Http.Client) {
            valkey = data.valkey.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
        }
    }
}

public extension Exoscale.DBaaS.Valkey.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let uri: [String]?
        public let password: String?
        /// Replica endpoints, retaining the API's field name for Codable and source compatibility.
        public let slave: [String]? // swiftlint:disable:this inclusive_language

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            uri: [String]? = nil,
            password: String? = nil,
            slave: [String]? = nil // swiftlint:disable:this inclusive_language
        ) {
            self.uri = uri
            self.password = password
            self.slave = slave
        }
    }
}
