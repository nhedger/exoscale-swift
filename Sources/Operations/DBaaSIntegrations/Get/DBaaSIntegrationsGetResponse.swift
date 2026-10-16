import Foundation

extension DBaaSIntegrationsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Integration.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Integration {
            Exoscale.DBaaS.Integration(data: data, client: client)
        }
    }
}
