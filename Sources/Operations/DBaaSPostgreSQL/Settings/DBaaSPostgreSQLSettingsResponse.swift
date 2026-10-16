import Foundation

extension DBaaSPostgreSQLOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSPostgreSQLSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.PostgreSQL.Settings {
            Exoscale.DBaaS.PostgreSQL.Settings(data: data.settings, client: client)
        }
    }
}
