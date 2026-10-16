import Foundation

extension DBaaSPostgreSQLOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let plan: String?
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
        let migration: Exoscale.DBaaS.PostgreSQL.Migration?
        let pgauditSettings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSPostgreSQLServiceBody(
                    pgbouncerSettings: pgbouncerSettings,
                    backupSchedule: backupSchedule,
                    variant: variant,
                    timescaledbSettings: timescaledbSettings,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    synchronousReplication: synchronousReplication,
                    pglookoutSettings: pglookoutSettings,
                    maintenance: maintenance,
                    version: version,
                    plan: plan,
                    workMem: workMem,
                    sharedBuffersPercentage: sharedBuffersPercentage,
                    pgSettings: pgSettings,
                    migration: migration,
                    pgauditSettings: pgauditSettings
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-postgres/\(name)",
                body: body
            )
        }
    }
}
