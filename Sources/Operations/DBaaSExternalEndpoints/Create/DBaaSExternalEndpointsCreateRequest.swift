import Foundation

extension DBaaSExternalEndpointsOperations.Create {
    struct Request: HttpRequest {
        let kind: String
        let name: String
        let settings: [String: Exoscale.JSONValue]

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(DBaaSExternalEndpointSettingsBody(settings: settings))

            return Http.Request(
                method: .post,
                path: "/dbaas-external-endpoint-\(kind)/\(name)",
                body: body
            )
        }
    }
}
