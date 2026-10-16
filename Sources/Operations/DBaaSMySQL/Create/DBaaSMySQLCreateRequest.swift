import Foundation

extension DBaaSMySQLOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
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
        let adminPassword: String?
        let migration: Exoscale.DBaaS.Migration?
        let binlogRetentionPeriod: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSMySQLServiceBody(
                    backupSchedule: backupSchedule,
                    integrations: integrations,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    recoveryBackupTime: recoveryBackupTime,
                    mysqlSettings: mysqlSettings,
                    maintenance: maintenance,
                    adminUsername: adminUsername,
                    version: version,
                    plan: plan,
                    adminPassword: adminPassword,
                    migration: migration,
                    binlogRetentionPeriod: binlogRetentionPeriod
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-mysql/\(name)",
                body: body
            )
        }
    }
}
