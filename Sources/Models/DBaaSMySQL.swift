import Foundation

public extension Exoscale.DBaaS.MySQL {
    enum AuthenticationPlugin: Exoscale.ExtensibleEnum {
        case cachingSHA2Password
        case mysqlNativePassword
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.cachingSHA2Password, .mysqlNativePassword]

        public var rawValue: String {
            switch self {
            case .cachingSHA2Password: "caching_sha2_password"
            case .mysqlNativePassword: "mysql_native_password"
            case let .unknown(value): value
            }
        }
    }

    /// MySQL service returned by the API.
    struct Service: Hashable, Sendable {
        public let updatedAt: Date?
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
        public let binlogRetentionPeriod: Int?
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
            backupSchedule: Exoscale.DBaaS.BackupSchedule? = nil,
            nodeCPUCount: Int? = nil,
            prometheusURI: Exoscale.DBaaS.PrometheusURI? = nil,
            integrations: [Exoscale.DBaaS.Integration]? = nil,
            zone: String? = nil,
            nodeStates: [Exoscale.DBaaS.NodeState]? = nil,
            name: String? = nil,
            type: String? = nil,
            state: String? = nil,
            databases: [String]? = nil,
            ipFilter: [String]? = nil,
            backups: [Exoscale.DBaaS.Backup]? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Exoscale.DBaaS.Notification]? = nil,
            components: [Exoscale.DBaaS.Component]? = nil,
            mysqlSettings: [String: Exoscale.JSONValue]? = nil,
            binlogRetentionPeriod: Int? = nil,
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
            self.backupSchedule = backupSchedule
            self.nodeCPUCount = nodeCPUCount
            self.prometheusURI = prometheusURI
            self.integrations = integrations
            self.zone = zone
            self.nodeStates = nodeStates
            self.name = name
            self.type = type
            self.state = state
            self.databases = databases
            self.ipFilter = ipFilter
            self.backups = backups
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.components = components
            self.mysqlSettings = mysqlSettings
            self.binlogRetentionPeriod = binlogRetentionPeriod
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
            backupSchedule = data.backupSchedule
            nodeCPUCount = data.nodeCPUCount
            prometheusURI = data.prometheusURI.map { Exoscale.DBaaS.PrometheusURI(data: $0, client: client) }
            integrations = data.integrations.map { $0.map { Exoscale.DBaaS.Integration(data: $0, client: client) } }
            zone = data.zone
            nodeStates = data.nodeStates.map { $0.map { Exoscale.DBaaS.NodeState(data: $0, client: client) } }
            name = data.name
            type = data.type
            state = data.state
            databases = data.databases
            ipFilter = data.ipFilter
            backups = data.backups.map { $0.map { Exoscale.DBaaS.Backup(data: $0, client: client) } }
            terminationProtection = data.terminationProtection
            notifications = data.notifications.map { $0.map { Exoscale.DBaaS.Notification(data: $0, client: client) } }
            components = data.components.map { $0.map { Exoscale.DBaaS.Component(data: $0, client: client) } }
            mysqlSettings = data.mysqlSettings
            binlogRetentionPeriod = data.binlogRetentionPeriod
            maintenance = data.maintenance
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            uri = data.uri
            uriParams = data.uriParams
            version = data.version
            createdAt = data.createdAt
            plan = data.plan
            users = data.users
        }
    }

    /// MySQL user credentials returned by the API.
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

    /// MySQL settings schema returned by the API.
    struct Settings: Hashable, Sendable {
        public let mysql: Exoscale.DBaaS.SettingsSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            mysql: Exoscale.DBaaS.SettingsSchema? = nil
        ) {
            self.mysql = mysql
        }

        init(data: Payload, client: Http.Client) {
            mysql = data.mysql.map { Exoscale.DBaaS.SettingsSchema(data: $0, client: client) }
        }
    }
}

public extension Exoscale.DBaaS.MySQL.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let uri: [String]?
        public let params: [[String: String]]?
        public let standby: [String]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            uri: [String]? = nil,
            params: [[String: String]]? = nil,
            standby: [String]? = nil
        ) {
            self.uri = uri
            self.params = params
            self.standby = standby
        }
    }
}

public extension Exoscale.DBaaS.MySQL.Service {
    struct User: Codable, Hashable, Sendable {
        public let type: String?
        public let username: String?
        public let password: String?
        public let authentication: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: String? = nil,
            username: String? = nil,
            password: String? = nil,
            authentication: String? = nil
        ) {
            self.type = type
            self.username = username
            self.password = password
            self.authentication = authentication
        }
    }
}
