import Foundation

/// Request body for updating a DBaaS PostgreSQL service.
struct UpdateDBaaSPostgreSQLServiceBody: Encodable, Sendable {
    let pgbouncerSettings: [String: Exoscale.JSONValue]?
    let backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule?
    let variant: Exoscale.DBaaS.PostgreSQL.Variant?
    let timescaledbSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication?
    let pglookoutSettings: [String: Exoscale.JSONValue]?
    let maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance?
    let version: String?
    let plan: String?
    let workMem: Int?
    let sharedBuffersPercentage: Int?
    let pgSettings: [String: Exoscale.JSONValue]?
    let migration: Exoscale.DBaaS.PostgreSQL.Migration?
    var pgauditSettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case pgbouncerSettings = "pgbouncer-settings"
        case backupSchedule = "backup-schedule"
        case variant
        case timescaledbSettings = "timescaledb-settings"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case synchronousReplication = "synchronous-replication"
        case pglookoutSettings = "pglookout-settings"
        case maintenance
        case version
        case plan
        case workMem = "work-mem"
        case sharedBuffersPercentage = "shared-buffers-percentage"
        case pgSettings = "pg-settings"
        case migration
        case pgauditSettings = "pgaudit-settings"
    }
}
