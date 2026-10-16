import Foundation

extension DBaaSExternalEndpointsOperations.Update {
    struct Request: HttpRequest {
        let kind: String
        let id: String
        let settings: [String: Exoscale.JSONValue]

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(DBaaSExternalEndpointSettingsBody(settings: settings))

            return Http.Request(
                method: .put,
                path: "/dbaas-external-endpoint-\(kind)/\(id)",
                body: body
            )
        }
    }
}
