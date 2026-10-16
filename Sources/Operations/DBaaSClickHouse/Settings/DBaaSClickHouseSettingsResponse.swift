import Foundation

extension DBaaSClickHouseOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSClickHouseSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.ClickHouse.Settings {
            Exoscale.DBaaS.ClickHouse.Settings(data: data.settings, client: client)
        }
    }
}
