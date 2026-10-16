import Foundation

extension DBaaSGrafanaOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Grafana.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Grafana.Service {
            Exoscale.DBaaS.Grafana.Service(data: data, client: client)
        }
    }
}
