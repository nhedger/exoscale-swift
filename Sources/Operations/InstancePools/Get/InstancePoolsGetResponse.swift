import Foundation

extension InstancePoolsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.InstancePool.Payload

        func transform(client: Http.Client) -> Exoscale.InstancePool {
            Exoscale.InstancePool(data: data, client: client)
        }
    }
}
