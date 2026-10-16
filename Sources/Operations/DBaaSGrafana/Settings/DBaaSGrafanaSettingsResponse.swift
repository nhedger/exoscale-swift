import Foundation

extension DBaaSGrafanaOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSGrafanaSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.Grafana.Settings {
            Exoscale.DBaaS.Grafana.Settings(data: data.settings, client: client)
        }
    }
}
