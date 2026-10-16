import Foundation

extension InstancesOperations.RevealPassword {
    struct Response: HttpResponse {
        let data: Exoscale.InstancePassword.Payload

        func transform(client: Http.Client) -> Exoscale.InstancePassword {
            Exoscale.InstancePassword(data: data, client: client)
        }
    }
}
