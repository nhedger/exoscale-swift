import Foundation

extension CryptoOperations.Encrypt {
    struct Response: HttpResponse {
        let data: EncryptData

        func transform(client _: Http.Client) -> String {
            data.ciphertext
        }
    }
}
