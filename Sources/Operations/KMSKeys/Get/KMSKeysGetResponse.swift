import Foundation

extension KMSKeysOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.KMSKey.Payload

        func transform(client: Http.Client) -> Exoscale.KMSKey {
            Exoscale.KMSKey(data: data, client: client)
        }
    }
}
