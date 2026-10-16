import Foundation

extension ElasticIPsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.ElasticIP.Payload

        func transform(client: Http.Client) -> Exoscale.ElasticIP {
            Exoscale.ElasticIP(data: data, client: client)
        }
    }
}
