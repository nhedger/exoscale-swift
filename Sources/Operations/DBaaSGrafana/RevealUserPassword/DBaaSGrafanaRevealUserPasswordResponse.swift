import Foundation

extension DBaaSGrafanaOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Grafana.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Grafana.UserSecrets {
            Exoscale.DBaaS.Grafana.UserSecrets(data: data, client: client)
        }
    }
}
