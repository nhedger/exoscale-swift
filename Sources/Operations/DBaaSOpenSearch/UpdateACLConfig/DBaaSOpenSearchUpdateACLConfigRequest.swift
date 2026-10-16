import Foundation

extension DBaaSOpenSearchOperations.UpdateACLConfig {
    struct Request: HttpRequest {
        let name: String
        let config: Exoscale.DBaaS.OpenSearch.ACLConfig

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(config)

            return Http.Request(
                method: .put,
                path: "/dbaas-opensearch/\(name)/acl-config",
                body: body
            )
        }
    }
}
