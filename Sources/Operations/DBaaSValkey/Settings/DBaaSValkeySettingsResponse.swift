import Foundation

extension DBaaSValkeyOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSValkeySettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.Valkey.Settings {
            Exoscale.DBaaS.Valkey.Settings(data: data.settings, client: client)
        }
    }
}
