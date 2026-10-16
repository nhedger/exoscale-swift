import Foundation

extension DBaaSGrafanaOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let plan: String?
        let terminationProtection: Bool?
        let grafanaSettings: [String: Exoscale.JSONValue]?
        let ipFilter: [String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSGrafanaServiceBody(
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    grafanaSettings: grafanaSettings,
                    ipFilter: ipFilter
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-grafana/\(name)",
                body: body
            )
        }
    }
}
