import Foundation

extension SSHKeysOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.SSHKey.Payload

        func transform(client: Http.Client) -> Exoscale.SSHKey {
            Exoscale.SSHKey(data: data, client: client)
        }
    }
}
