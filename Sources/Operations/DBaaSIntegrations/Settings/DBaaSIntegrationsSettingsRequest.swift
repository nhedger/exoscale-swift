import Foundation

extension DBaaSIntegrationsOperations.Settings {
    struct Request: HttpRequest {
        let integrationType: String
        let sourceType: String
        let destinationType: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-integration-settings/\(integrationType)/\(sourceType)/\(destinationType)"
            )
        }
    }
}
