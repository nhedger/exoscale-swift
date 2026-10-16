import Foundation

extension DBaaSExternalEndpointsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-endpoints"
            )
        }
    }
}
