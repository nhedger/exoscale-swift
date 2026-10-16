import Foundation

extension DBaaSIntegrationsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-integration/\(id)"
            )
        }
    }
}
