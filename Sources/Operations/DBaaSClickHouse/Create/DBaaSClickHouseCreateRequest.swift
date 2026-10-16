import Foundation

extension DBaaSClickHouseOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let terminationProtection: Bool?
        let version: String?
        let ipFilter: [String]?
        let clickhouseSettings: [String: Exoscale.JSONValue]?
        let forkFromService: String?
        let recoveryBackupName: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(DBaaSClickHouseServiceBody(
                plan: plan, maintenance: maintenance, terminationProtection: terminationProtection,
                version: version, ipFilter: ipFilter, clickhouseSettings: clickhouseSettings,
                forkFromService: forkFromService, recoveryBackupName: recoveryBackupName
            ))

            return Http.Request(
                method: .post,
                path: "/dbaas-clickhouse/\(name)",
                body: body
            )
        }
    }
}
