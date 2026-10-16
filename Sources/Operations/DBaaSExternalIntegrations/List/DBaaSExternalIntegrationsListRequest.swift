import Foundation

extension DBaaSExternalIntegrationsOperations.List {
    struct Request: HttpRequest {
        let serviceName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-integrations/\(serviceName)"
            )
        }
    }
}
