import Foundation

extension CryptoOperations.Encrypt {
    struct Request: HttpRequest {
        let id: String
        let plaintext: String
        let encryptionContext: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                EncryptBody(encryptionContext: encryptionContext, plaintext: plaintext)
            )

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/encrypt",
                body: body
            )
        }
    }
}
