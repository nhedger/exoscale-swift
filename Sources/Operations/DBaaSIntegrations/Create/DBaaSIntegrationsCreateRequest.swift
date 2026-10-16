import Foundation

extension DBaaSIntegrationsOperations.Create {
    struct Request: HttpRequest {
        let type: Exoscale.DBaaS.IntegrationType
        let sourceService: String
        let destinationService: String
        let settings: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSIntegrationBody(
                    integrationType: type,
                    sourceService: sourceService,
                    destinationService: destinationService,
                    settings: settings
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-integration",
                body: body
            )
        }
    }
}
