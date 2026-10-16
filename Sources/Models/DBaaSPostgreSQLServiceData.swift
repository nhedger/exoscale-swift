import Foundation

extension Exoscale.DBaaS.PostgreSQL.Service {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let pgbouncerSettings: [String: Exoscale.JSONValue]?
        let updatedAt: Date?
        let nodeCount: Int?
        let connectionInfo: ConnectionInfo?
        let backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule?
        let nodeCPUCount: Int?
        let prometheusURI: PrometheusURI?
        let integrations: [Integration]?
        let zone: String?
        let nodeStates: [NodeState]?
        let name: String?
        let connectionPools: [ConnectionPool]?
        let type: String?
        let state: String?
        let timescaledbSettings: [String: Exoscale.JSONValue]?
        let databases: [String]?
        let ipFilter: [String]?
        let backups: [Backup]?
        let terminationProtection: Bool?
        let notifications: [Notification]?
        let components: [Component]?
        let synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication?
        let pglookoutSettings: [String: Exoscale.JSONValue]?
        let maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance?
        let diskSize: Int?
        let nodeMemory: Int?
        let uri: String?
        let uriParams: [String: Exoscale.JSONValue]?
        let version: String?
        let createdAt: Date?
        let plan: String?
        let workMem: Int?
        let sharedBuffersPercentage: Int?
        let pgSettings: [String: Exoscale.JSONValue]?
        let pgauditSettings: [String: Exoscale.JSONValue]?
        let maxConnections: Int?
        let users: [Exoscale.DBaaS.PostgreSQL.User.Payload]?
    }
}

extension Exoscale.DBaaS.PostgreSQL.Service.Payload {
    enum CodingKeys: String, CodingKey {
        case pgbouncerSettings = "pgbouncer-settings"
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
        case connectionPools = "connection-pools"
        case type
        case state
        case timescaledbSettings = "timescaledb-settings"
        case databases
        case ipFilter = "ip-filter"
        case backups
        case terminationProtection = "termination-protection"
        case notifications
        case components
        case synchronousReplication = "synchronous-replication"
        case pglookoutSettings = "pglookout-settings"
        case maintenance
        case diskSize = "disk-size"
        case nodeMemory = "node-memory"
        case uri
        case uriParams = "uri-params"
        case version
        case createdAt = "created-at"
        case plan
        case workMem = "work-mem"
        case sharedBuffersPercentage = "shared-buffers-percentage"
        case pgSettings = "pg-settings"
        case pgauditSettings = "pgaudit-settings"
        case maxConnections = "max-connections"
        case users
    }
}
