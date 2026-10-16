import Foundation

extension DBaaSMySQLOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let plan: String?
        let terminationProtection: Bool?
        let ipFilter: [String]?
        let mysqlSettings: [String: Exoscale.JSONValue]?
        let migration: Exoscale.DBaaS.Migration?
        let binlogRetentionPeriod: Int?
        let backupSchedule: Exoscale.DBaaS.BackupSchedule?
        let version: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSMySQLServiceBody(
                    version: version,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    mysqlSettings: mysqlSettings,
                    migration: migration,
                    binlogRetentionPeriod: binlogRetentionPeriod,
                    backupSchedule: backupSchedule
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-mysql/\(name)",
                body: body
            )
        }
    }
}
