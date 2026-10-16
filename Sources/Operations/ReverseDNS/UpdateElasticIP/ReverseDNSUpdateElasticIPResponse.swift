import Foundation

extension ReverseDNSOperations.UpdateElasticIP {
    struct Response: HttpResponse {
        let data: Exoscale.Operation.Payload

        func transform(client: Http.Client) -> Exoscale.Operation {
            Exoscale.Operation(data: data, client: client)
        }
    }
}
