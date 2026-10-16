import Foundation

extension DBaaSExternalEndpointsOperations.Get {
    struct Request: HttpRequest {
        let kind: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-endpoint-\(kind)/\(id)"
            )
        }
    }
}
