import Foundation

extension NodepoolsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.SKSNodepool.Payload

        func transform(client: Http.Client) -> Exoscale.SKSNodepool {
            Exoscale.SKSNodepool(data: data, client: client)
        }
    }
}
