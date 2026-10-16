import Foundation

extension DBaaSIntegrationsOperations.Types {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-integration-types"
            )
        }
    }
}
