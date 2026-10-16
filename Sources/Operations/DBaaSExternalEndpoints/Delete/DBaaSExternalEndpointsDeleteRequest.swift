import Foundation

extension DBaaSExternalEndpointsOperations.Delete {
    struct Request: HttpRequest {
        let kind: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-external-endpoint-\(kind)/\(id)"
            )
        }
    }
}
