import Foundation

extension DBaaSIntegrationsOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSIntegrationSettingsData

        func transform(client _: Http.Client) -> [String: Exoscale.JSONValue] {
            data.settings
        }
    }
}
