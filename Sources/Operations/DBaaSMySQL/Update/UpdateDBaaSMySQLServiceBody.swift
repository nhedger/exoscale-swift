import Foundation

/// Request body for updating a DBaaS MySQL service.
struct UpdateDBaaSMySQLServiceBody: Encodable, Sendable {
    var version: String?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let mysqlSettings: [String: Exoscale.JSONValue]?
    let migration: Exoscale.DBaaS.Migration?
    let binlogRetentionPeriod: Int?
    let backupSchedule: Exoscale.DBaaS.BackupSchedule?

    enum CodingKeys: String, CodingKey {
        case version
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case mysqlSettings = "mysql-settings"
        case migration
        case binlogRetentionPeriod = "binlog-retention-period"
        case backupSchedule = "backup-schedule"
    }
}
