import Foundation

extension DBaaSOpenSearchOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSOpenSearchSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.OpenSearch.Settings {
            Exoscale.DBaaS.OpenSearch.Settings(data: data.settings, client: client)
        }
    }
}
