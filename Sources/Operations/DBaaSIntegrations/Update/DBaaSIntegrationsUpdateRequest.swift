import Foundation

extension DBaaSIntegrationsOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let settings: [String: Exoscale.JSONValue]

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateDBaaSIntegrationBody(settings: settings))

            return Http.Request(
                method: .put,
                path: "/dbaas-integration/\(id)",
                body: body
            )
        }
    }
}
