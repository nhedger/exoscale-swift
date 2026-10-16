import Foundation

extension DBaaSClickHouseOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let plan: String?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let terminationProtection: Bool?
        let version: String?
        let ipFilter: [String]?
        let clickhouseSettings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(DBaaSClickHouseServiceBody(
                plan: plan, maintenance: maintenance, terminationProtection: terminationProtection,
                version: version, ipFilter: ipFilter, clickhouseSettings: clickhouseSettings
            ))

            return Http.Request(
                method: .put,
                path: "/dbaas-clickhouse/\(name)",
                body: body
            )
        }
    }
}
