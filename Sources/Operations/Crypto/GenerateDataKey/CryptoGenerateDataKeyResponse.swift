import Foundation

extension CryptoOperations.GenerateDataKey {
    struct Response: HttpResponse {
        let data: Exoscale.CryptoDataKey.Payload

        func transform(client: Http.Client) -> Exoscale.CryptoDataKey {
            Exoscale.CryptoDataKey(data: data, client: client)
        }
    }
}
