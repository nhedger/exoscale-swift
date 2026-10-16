import Foundation

extension APIKeysOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.APIKey.Payload

        func transform(client: Http.Client) -> Exoscale.APIKey {
            Exoscale.APIKey(data: data, client: client)
        }
    }
}
