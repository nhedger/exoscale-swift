import Foundation

extension CryptoOperations.ReEncrypt {
    struct Response: HttpResponse {
        let data: ReEncryptData

        func transform(client _: Http.Client) -> String {
            data.ciphertext
        }
    }
}
