import Foundation

/// Request body for creating a DBaaS PostgreSQL service.
struct CreateDBaaSPostgreSQLServiceBody: Encodable, Sendable {
    let pgbouncerSettings: [String: Exoscale.JSONValue]?
    let backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule?
    let variant: Exoscale.DBaaS.PostgreSQL.Variant?
    let integrations: [Exoscale.DBaaS.PostgreSQL.IntegrationInput]?
    let timescaledbSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let forkFromService: String?
    let synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication?
    let recoveryBackupTime: String?
    let pglookoutSettings: [String: Exoscale.JSONValue]?
    let maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance?
    let adminUsername: String?
    let version: String?
    let plan: String
    let workMem: Int?
    let sharedBuffersPercentage: Int?
    let pgSettings: [String: Exoscale.JSONValue]?
    let adminPassword: String?
    let migration: Exoscale.DBaaS.PostgreSQL.Migration?
    var pgauditSettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case pgbouncerSettings = "pgbouncer-settings"
        case backupSchedule = "backup-schedule"
        case variant
        case integrations
        case timescaledbSettings = "timescaledb-settings"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case synchronousReplication = "synchronous-replication"
        case recoveryBackupTime = "recovery-backup-time"
        case pglookoutSettings = "pglookout-settings"
        case maintenance
        case adminUsername = "admin-username"
        case version
        case plan
        case workMem = "work-mem"
        case sharedBuffersPercentage = "shared-buffers-percentage"
        case pgSettings = "pg-settings"
        case adminPassword = "admin-password"
        case migration
        case pgauditSettings = "pgaudit-settings"
    }
}
