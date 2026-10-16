import Foundation

extension CryptoOperations.Decrypt {
    struct Request: HttpRequest {
        let id: String
        let ciphertext: String
        let encryptionContext: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                DecryptBody(encryptionContext: encryptionContext, ciphertext: ciphertext)
            )

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/decrypt",
                body: body
            )
        }
    }
}
