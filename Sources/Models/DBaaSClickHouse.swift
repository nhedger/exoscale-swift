import Foundation

public extension Exoscale.DBaaS {
    /// ClickHouse database service types (beta).
    enum ClickHouse {}
}

public extension Exoscale.DBaaS.ClickHouse {
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
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let clickhouseSettings: [String: Exoscale.JSONValue]?
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
            ipFilter: [String]? = nil,
            backups: [Exoscale.DBaaS.Backup]? = nil,
            terminationProtection: Bool? = nil,
            clickhouseSettings: [String: Exoscale.JSONValue]? = nil,
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
            self.ipFilter = ipFilter
            self.backups = backups
            self.terminationProtection = terminationProtection
            self.clickhouseSettings = clickhouseSettings
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
            ipFilter = data.ipFilter
            backups = data.backups.map { $0.map { Exoscale.DBaaS.Backup(data: $0, client: client) } }
            terminationProtection = data.terminationProtection
            clickhouseSettings = data.clickhouseSettings
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
            users = data.users.map { $0.map { Exoscale.DBaaS.ClickHouse.User(data: $0, client: client) } }
        }
    }

    struct User: Hashable, Sendable {
        public let username: String
        public let uuid: String?
        public let required: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String,
            uuid: String? = nil,
            required: Bool? = nil
        ) {
            self.username = username
            self.uuid = uuid
            self.required = required
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            uuid = data.uuid
            required = data.required
        }
    }

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

    struct RoleReference: Codable, Hashable, Sendable {
        public let uuid: String

        public init(uuid: String) {
            self.uuid = uuid
        }
    }

    struct Role: Hashable, Sendable {
        public let name: String
        public let uuid: String?
        public let privileges: [[String: Exoscale.JSONValue]]?
        public let grantedRoles: [[String: Exoscale.JSONValue]]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String,
            uuid: String? = nil,
            privileges: [[String: Exoscale.JSONValue]]? = nil,
            grantedRoles: [[String: Exoscale.JSONValue]]? = nil
        ) {
            self.name = name
            self.uuid = uuid
            self.privileges = privileges
            self.grantedRoles = grantedRoles
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            uuid = data.uuid
            privileges = data.privileges
            grantedRoles = data.grantedRoles
        }
    }

    struct UserACL: Hashable, Sendable {
        public let username: String
        public let uuid: String?
        public let roles: [[String: Exoscale.JSONValue]]?
        public let privileges: [[String: Exoscale.JSONValue]]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String,
            uuid: String? = nil,
            roles: [[String: Exoscale.JSONValue]]? = nil,
            privileges: [[String: Exoscale.JSONValue]]? = nil
        ) {
            self.username = username
            self.uuid = uuid
            self.roles = roles
            self.privileges = privileges
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            uuid = data.uuid
            roles = data.roles
            privileges = data.privileges
        }
    }

    struct ACLConfig: Hashable, Sendable {
        public let users: [UserACL]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            users: [UserACL]? = nil
        ) {
            self.users = users
        }

        init(data: Payload, client: Http.Client) {
            users = data.users.map { $0.map { Exoscale.DBaaS.ClickHouse.UserACL(data: $0, client: client) } }
        }
    }

    struct Settings: Hashable, Sendable {
        public let clickhouse: Exoscale.DBaaS.SettingsSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            clickhouse: Exoscale.DBaaS.SettingsSchema? = nil
        ) {
            self.clickhouse = clickhouse
        }

        init(data: Payload, client: Http.Client) {
            clickhouse = data.clickhouse.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
        }
    }
}

extension Exoscale.DBaaS.ClickHouse.Service.ConnectionInfo {
    enum CodingKeys: String, CodingKey {
        case uri
        case mysqlURI = "mysql-uri"
        case arrowflightURI = "arrowflight-uri"
    }
}

public extension Exoscale.DBaaS.ClickHouse.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let uri: [String]?
        public let mysqlURI: String?
        public let arrowflightURI: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            uri: [String]? = nil,
            mysqlURI: String? = nil,
            arrowflightURI: String? = nil
        ) {
            self.uri = uri
            self.mysqlURI = mysqlURI
            self.arrowflightURI = arrowflightURI
        }
    }
}
