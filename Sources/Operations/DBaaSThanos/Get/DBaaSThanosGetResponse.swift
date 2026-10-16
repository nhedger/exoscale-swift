import Foundation

extension DBaaSThanosOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Thanos.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Thanos.Service {
            Exoscale.DBaaS.Thanos.Service(data: data, client: client)
        }
    }
}
