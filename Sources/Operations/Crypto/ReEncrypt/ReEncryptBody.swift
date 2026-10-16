import Foundation

/// Request body for re-encrypting ciphertext between KMS keys.
struct ReEncryptBody: Encodable, Sendable {
    let source: Source
    let destination: Destination

    init(
        sourceKeyID: String,
        destinationKeyID: String,
        ciphertext: String,
        sourceEncryptionContext: String? = nil,
        destinationEncryptionContext: String? = nil
    ) {
        source = Source(
            key: sourceKeyID,
            encryptionContext: sourceEncryptionContext,
            ciphertext: ciphertext
        )
        destination = Destination(
            key: destinationKeyID,
            encryptionContext: destinationEncryptionContext
        )
    }
}

extension ReEncryptBody.Source {
    enum CodingKeys: String, CodingKey {
        case key
        case encryptionContext = "encryption-context"
        case ciphertext
    }
}

extension ReEncryptBody {
    struct Source: Encodable, Sendable {
        let key: String
        let encryptionContext: String?
        let ciphertext: String
    }
}

extension ReEncryptBody.Destination {
    enum CodingKeys: String, CodingKey {
        case key
        case encryptionContext = "encryption-context"
    }
}

extension ReEncryptBody {
    struct Destination: Encodable, Sendable {
        let key: String
        let encryptionContext: String?
    }
}
