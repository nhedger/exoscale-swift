import Foundation

extension DBaaSExternalIntegrationsOperations.DatadogSettings {
    struct Response: HttpResponse {
        let data: GetDBaaSDatadogSettingsData

        func transform(client _: Http.Client) -> Exoscale.DBaaS.DatadogIntegrationSettings {
            data.settings
        }
    }
}
