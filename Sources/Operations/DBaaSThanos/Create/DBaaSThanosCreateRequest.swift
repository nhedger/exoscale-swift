import Foundation

extension DBaaSThanosOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let plan: String
        let maintenance: Exoscale.DBaaS.Maintenance?
        let terminationProtection: Bool?
        let ipFilter: [String]?
        let thanosSettings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSThanosServiceBody(
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    thanosSettings: thanosSettings
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-thanos/\(name)",
                body: body
            )
        }
    }
}
