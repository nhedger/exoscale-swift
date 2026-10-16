import Foundation

extension DBaaSThanosOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let plan: String?
        let terminationProtection: Bool?
        let ipFilter: [String]?
        let thanosSettings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSThanosServiceBody(
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    thanosSettings: thanosSettings
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-thanos/\(name)",
                body: body
            )
        }
    }
}
