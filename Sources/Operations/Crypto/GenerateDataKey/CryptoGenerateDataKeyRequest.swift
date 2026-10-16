import Foundation

extension CryptoOperations.GenerateDataKey {
    struct Request: HttpRequest {
        let id: String
        let keySpec: Exoscale.CryptoDataKey.KeySpec?
        let bytesCount: Int?
        let encryptionContext: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                GenerateDataKeyBody(
                    keySpec: keySpec,
                    bytesCount: bytesCount,
                    encryptionContext: encryptionContext
                )
            )

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/generate-data-key",
                body: body
            )
        }
    }
}
