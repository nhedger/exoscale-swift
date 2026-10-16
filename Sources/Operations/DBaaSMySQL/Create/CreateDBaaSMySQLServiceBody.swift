import Foundation

/// Request body for creating a DBaaS MySQL service.
struct CreateDBaaSMySQLServiceBody: Encodable, Sendable {
    let backupSchedule: Exoscale.DBaaS.BackupSchedule?
    let integrations: [Exoscale.DBaaS.IntegrationInput]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let forkFromService: String?
    let recoveryBackupTime: String?
    let mysqlSettings: [String: Exoscale.JSONValue]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let adminUsername: String?
    let version: String?
    let plan: String
    let adminPassword: String?
    let migration: Exoscale.DBaaS.Migration?
    let binlogRetentionPeriod: Int?

    enum CodingKeys: String, CodingKey {
        case backupSchedule = "backup-schedule"
        case integrations
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case recoveryBackupTime = "recovery-backup-time"
        case mysqlSettings = "mysql-settings"
        case maintenance
        case adminUsername = "admin-username"
        case version
        case plan
        case adminPassword = "admin-password"
        case migration
        case binlogRetentionPeriod = "binlog-retention-period"
    }
}
