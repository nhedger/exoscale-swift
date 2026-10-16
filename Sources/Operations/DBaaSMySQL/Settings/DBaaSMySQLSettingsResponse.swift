import Foundation

extension DBaaSMySQLOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSMySQLSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.MySQL.Settings {
            Exoscale.DBaaS.MySQL.Settings(data: data.settings, client: client)
        }
    }
}
