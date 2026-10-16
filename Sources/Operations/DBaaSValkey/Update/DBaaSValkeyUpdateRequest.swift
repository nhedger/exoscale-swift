import Foundation

extension DBaaSValkeyOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let plan: String?
        let terminationProtection: Bool?
        let ipFilter: [String]?
        let migration: Exoscale.DBaaS.Migration?
        let valkeySettings: [String: Exoscale.JSONValue]?
        let version: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSValkeyServiceBody(
                    version: version,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    migration: migration,
                    valkeySettings: valkeySettings
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-valkey/\(name)",
                body: body
            )
        }
    }
}
