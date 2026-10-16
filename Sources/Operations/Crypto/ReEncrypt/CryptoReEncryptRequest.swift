import Foundation

extension CryptoOperations.ReEncrypt {
    struct Request: HttpRequest {
        let id: String
        let sourceKeyID: String
        let destinationKeyID: String
        let ciphertext: String
        let sourceEncryptionContext: String?
        let destinationEncryptionContext: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                ReEncryptBody(
                    sourceKeyID: sourceKeyID,
                    destinationKeyID: destinationKeyID,
                    ciphertext: ciphertext,
                    sourceEncryptionContext: sourceEncryptionContext,
                    destinationEncryptionContext: destinationEncryptionContext
                )
            )

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/re-encrypt",
                body: body
            )
        }
    }
}
