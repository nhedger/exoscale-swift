import Foundation

extension DBaaSValkeyOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Valkey.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Valkey.Service {
            Exoscale.DBaaS.Valkey.Service(data: data, client: client)
        }
    }
}
