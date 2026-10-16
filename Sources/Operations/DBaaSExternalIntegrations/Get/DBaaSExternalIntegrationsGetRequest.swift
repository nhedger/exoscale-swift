import Foundation

extension DBaaSExternalIntegrationsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-integration/\(id)"
            )
        }
    }
}
