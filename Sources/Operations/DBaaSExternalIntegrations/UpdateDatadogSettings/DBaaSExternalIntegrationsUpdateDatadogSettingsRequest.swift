import Foundation

extension DBaaSExternalIntegrationsOperations.UpdateDatadogSettings {
    struct Request: HttpRequest {
        let integrationID: String
        let settings: Exoscale.DBaaS.DatadogIntegrationSettings

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateDBaaSDatadogSettingsBody(settings: settings))

            return Http.Request(
                method: .post,
                path: "/dbaas-external-integration-settings-datadog/\(integrationID)",
                body: body
            )
        }
    }
}
