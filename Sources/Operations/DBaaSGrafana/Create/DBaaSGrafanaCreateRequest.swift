import Foundation

extension DBaaSGrafanaOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let terminationProtection: Bool?
        let forkFromService: String?
        let grafanaSettings: [String: Exoscale.JSONValue]?
        let ipFilter: [String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSGrafanaServiceBody(
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    grafanaSettings: grafanaSettings,
                    ipFilter: ipFilter
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-grafana/\(name)",
                body: body
            )
        }
    }
}
