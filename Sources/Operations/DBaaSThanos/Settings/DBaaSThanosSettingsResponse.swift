import Foundation

extension DBaaSThanosOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSThanosSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.Thanos.Settings {
            Exoscale.DBaaS.Thanos.Settings(data: data.settings, client: client)
        }
    }
}
