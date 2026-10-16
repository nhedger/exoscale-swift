import Foundation

extension APIKeysOperations.Create {
    struct Response: HttpResponse {
        let data: Exoscale.APIKeyWithSecret.Payload

        func transform(client: Http.Client) -> Exoscale.APIKeyWithSecret {
            Exoscale.APIKeyWithSecret(data: data, client: client)
        }
    }
}
