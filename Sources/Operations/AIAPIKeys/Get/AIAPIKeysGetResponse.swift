import Foundation

extension AIAPIKeysOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.AIAPIKey.Payload

        func transform(client: Http.Client) -> Exoscale.AIAPIKey {
            Exoscale.AIAPIKey(data: data, client: client)
        }
    }
}
