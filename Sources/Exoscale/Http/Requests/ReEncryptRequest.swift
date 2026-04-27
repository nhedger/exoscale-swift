/// Request body for re-encrypting ciphertext between KMS keys.
struct ReEncryptRequest: Codable, Sendable {
    struct Source: Codable, Sendable {
        let key: String
        let encryptionContext: String?
        let ciphertext: String

        enum CodingKeys: String, CodingKey {
            case key
            case encryptionContext = "encryption-context"
            case ciphertext
        }
    }

    struct Destination: Codable, Sendable {
        let key: String
        let encryptionContext: String?

        enum CodingKeys: String, CodingKey {
            case key
            case encryptionContext = "encryption-context"
        }
    }

    let source: Source
    let destination: Destination

    init(
        sourceKeyID: String,
        destinationKeyID: String,
        ciphertext: String,
        sourceEncryptionContext: String? = nil,
        destinationEncryptionContext: String? = nil
    ) {
        self.source = Source(
            key: sourceKeyID,
            encryptionContext: sourceEncryptionContext,
            ciphertext: ciphertext
        )
        self.destination = Destination(
            key: destinationKeyID,
            encryptionContext: destinationEncryptionContext
        )
    }
}
