import Foundation

extension InstancesOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Instance.Payload

        func transform(client: Http.Client) -> Exoscale.Instance {
            Exoscale.Instance(data: data, client: client)
        }
    }
}
