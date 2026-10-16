import Foundation

extension DBaaSPostgreSQLOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
        let version: String?
        let variant: Exoscale.DBaaS.PostgreSQL.Variant?
        let ipFilter: [String]?
        let terminationProtection: Bool?
        let maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance?
        let backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule?
        let pgbouncerSettings: [String: Exoscale.JSONValue]?
        let pgSettings: [String: Exoscale.JSONValue]?
        let pglookoutSettings: [String: Exoscale.JSONValue]?
        let timescaledbSettings: [String: Exoscale.JSONValue]?
        let synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication?
        let workMem: Int?
        let sharedBuffersPercentage: Int?
        let adminUsername: String?
        let adminPassword: String?
        let integrations: [Exoscale.DBaaS.PostgreSQL.IntegrationInput]?
        let forkFromService: String?
        let recoveryBackupTime: String?
        let migration: Exoscale.DBaaS.PostgreSQL.Migration?
        let pgauditSettings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSPostgreSQLServiceBody(
                    pgbouncerSettings: pgbouncerSettings,
                    backupSchedule: backupSchedule,
                    variant: variant,
                    integrations: integrations,
                    timescaledbSettings: timescaledbSettings,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    synchronousReplication: synchronousReplication,
                    recoveryBackupTime: recoveryBackupTime,
                    pglookoutSettings: pglookoutSettings,
                    maintenance: maintenance,
                    adminUsername: adminUsername,
                    version: version,
                    plan: plan,
                    workMem: workMem,
                    sharedBuffersPercentage: sharedBuffersPercentage,
                    pgSettings: pgSettings,
                    adminPassword: adminPassword,
                    migration: migration,
                    pgauditSettings: pgauditSettings
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(name)",
                body: body
            )
        }
    }
}
