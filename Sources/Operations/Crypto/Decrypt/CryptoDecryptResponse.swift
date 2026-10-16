import Foundation

extension CryptoOperations.Decrypt {
    struct Response: HttpResponse {
        let data: DecryptData

        func transform(client _: Http.Client) -> String {
            data.plaintext
        }
    }
}
