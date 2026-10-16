import Foundation

extension DBaaSExternalIntegrationsOperations.DatadogSettings {
    struct Request: HttpRequest {
        let integrationID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-external-integration-settings-datadog/\(integrationID)"
            )
        }
    }
}
