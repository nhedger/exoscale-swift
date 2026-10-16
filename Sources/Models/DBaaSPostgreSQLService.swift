import Foundation

public extension Exoscale.DBaaS.PostgreSQL {
    /// PostgreSQL service returned by the API.
    struct Service: Hashable, Sendable {
        public let pgbouncerSettings: [String: Exoscale.JSONValue]?
        public let updatedAt: Date?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let backupSchedule: BackupSchedule?
        public let nodeCPUCount: Int?
        public let prometheusURI: PrometheusURI?
        public let integrations: [Integration]?
        public let zone: String?
        public let nodeStates: [NodeState]?
        public let name: String?
        public let connectionPools: [ConnectionPool]?
        public let type: String?
        public let state: String?
        public let timescaledbSettings: [String: Exoscale.JSONValue]?
        public let databases: [String]?
        public let ipFilter: [String]?
        public let backups: [Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Notification]?
        public let components: [Component]?
        public let synchronousReplication: SynchronousReplication?
        public let pglookoutSettings: [String: Exoscale.JSONValue]?
        public let maintenance: Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: Date?
        public let plan: String?
        public let workMem: Int?
        public let sharedBuffersPercentage: Int?
        public let pgSettings: [String: Exoscale.JSONValue]?
        public let pgauditSettings: [String: Exoscale.JSONValue]?
        public let maxConnections: Int?
        public let users: [User]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            pgbouncerSettings: [String: Exoscale.JSONValue]? = nil,
            updatedAt: Date? = nil,
            nodeCount: Int? = nil,
            connectionInfo: ConnectionInfo? = nil,
            backupSchedule: BackupSchedule? = nil,
            nodeCPUCount: Int? = nil,
            prometheusURI: PrometheusURI? = nil,
            integrations: [Integration]? = nil,
            zone: String? = nil,
            nodeStates: [NodeState]? = nil,
            name: String? = nil,
            connectionPools: [ConnectionPool]? = nil,
            type: String? = nil,
            state: String? = nil,
            timescaledbSettings: [String: Exoscale.JSONValue]? = nil,
            databases: [String]? = nil,
            ipFilter: [String]? = nil,
            backups: [Backup]? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Notification]? = nil,
            components: [Component]? = nil,
            synchronousReplication: SynchronousReplication? = nil,
            pglookoutSettings: [String: Exoscale.JSONValue]? = nil,
            maintenance: Maintenance? = nil,
            diskSize: Int? = nil,
            nodeMemory: Int? = nil,
            uri: String? = nil,
            uriParams: [String: Exoscale.JSONValue]? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            plan: String? = nil,
            workMem: Int? = nil,
            sharedBuffersPercentage: Int? = nil,
            pgSettings: [String: Exoscale.JSONValue]? = nil,
            pgauditSettings: [String: Exoscale.JSONValue]? = nil,
            maxConnections: Int? = nil,
            users: [User]? = nil
        ) {
            self.pgbouncerSettings = pgbouncerSettings
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
            self.connectionPools = connectionPools
            self.type = type
            self.state = state
            self.timescaledbSettings = timescaledbSettings
            self.databases = databases
            self.ipFilter = ipFilter
            self.backups = backups
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.components = components
            self.synchronousReplication = synchronousReplication
            self.pglookoutSettings = pglookoutSettings
            self.maintenance = maintenance
            self.diskSize = diskSize
            self.nodeMemory = nodeMemory
            self.uri = uri
            self.uriParams = uriParams
            self.version = version
            self.createdAt = createdAt
            self.plan = plan
            self.workMem = workMem
            self.sharedBuffersPercentage = sharedBuffersPercentage
            self.pgSettings = pgSettings
            self.pgauditSettings = pgauditSettings
            self.maxConnections = maxConnections
            self.users = users
        }

        init(data: Payload, client: Http.Client) {
            pgbouncerSettings = data.pgbouncerSettings
            updatedAt = data.updatedAt
            nodeCount = data.nodeCount
            connectionInfo = data.connectionInfo
            backupSchedule = data.backupSchedule
            nodeCPUCount = data.nodeCPUCount
            prometheusURI = data.prometheusURI
            integrations = data.integrations
            zone = data.zone
            nodeStates = data.nodeStates
            name = data.name
            connectionPools = data.connectionPools
            type = data.type
            state = data.state
            timescaledbSettings = data.timescaledbSettings
            databases = data.databases
            ipFilter = data.ipFilter
            backups = data.backups
            terminationProtection = data.terminationProtection
            notifications = data.notifications
            components = data.components
            synchronousReplication = data.synchronousReplication
            pglookoutSettings = data.pglookoutSettings
            maintenance = data.maintenance
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            uri = data.uri
            uriParams = data.uriParams
            version = data.version
            createdAt = data.createdAt
            plan = data.plan
            workMem = data.workMem
            sharedBuffersPercentage = data.sharedBuffersPercentage
            pgSettings = data.pgSettings
            pgauditSettings = data.pgauditSettings
            maxConnections = data.maxConnections
            users = data.users.map { $0.map { Exoscale.DBaaS.PostgreSQL.User(data: $0, client: client) } }
        }
    }
}
