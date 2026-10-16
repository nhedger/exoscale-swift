import Foundation

extension AIAPIKeysOperations.Create {
    struct Response: HttpResponse {
        let data: Exoscale.AIAPIKeyWithValue.Payload

        func transform(client: Http.Client) -> Exoscale.AIAPIKeyWithValue {
            Exoscale.AIAPIKeyWithValue(data: data, client: client)
        }
    }
}
