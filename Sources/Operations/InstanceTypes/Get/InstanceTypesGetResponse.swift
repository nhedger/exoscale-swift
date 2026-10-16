import Foundation

extension InstanceTypesOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.InstanceType.Payload

        func transform(client: Http.Client) -> Exoscale.InstanceType {
            Exoscale.InstanceType(data: data, client: client)
        }
    }
}
