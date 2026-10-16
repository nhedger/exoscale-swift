import Foundation

extension DBaaSIntegrationsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-integration/\(id)"
            )
        }
    }
}
