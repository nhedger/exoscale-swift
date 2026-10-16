import Foundation

extension DBaaSOpenSearchOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.OpenSearch.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.OpenSearch.Service {
            Exoscale.DBaaS.OpenSearch.Service(data: data, client: client)
        }
    }
}
