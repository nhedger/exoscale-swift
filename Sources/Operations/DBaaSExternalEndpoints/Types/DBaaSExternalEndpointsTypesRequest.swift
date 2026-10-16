import Foundation

extension DBaaSExternalEndpointsOperations.Types {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-endpoint-types"
            )
        }
    }
}
