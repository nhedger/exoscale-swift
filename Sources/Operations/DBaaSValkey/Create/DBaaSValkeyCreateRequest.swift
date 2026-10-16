import Foundation

extension DBaaSValkeyOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let terminationProtection: Bool?
        let ipFilter: [String]?
        let migration: Exoscale.DBaaS.Migration?
        let valkeySettings: [String: Exoscale.JSONValue]?
        let forkFromService: String?
        let recoveryBackupName: String?
        let version: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSValkeyServiceBody(
                    version: version,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    migration: migration,
                    valkeySettings: valkeySettings,
                    forkFromService: forkFromService,
                    recoveryBackupName: recoveryBackupName
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-valkey/\(name)",
                body: body
            )
        }
    }
}
