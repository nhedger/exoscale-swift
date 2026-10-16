import Foundation

/// Request body for encrypting plaintext with a KMS key.
struct EncryptBody: Encodable, Sendable {
    let encryptionContext: String?
    let plaintext: String

    enum CodingKeys: String, CodingKey {
        case encryptionContext = "encryption-context"
        case plaintext
    }
}
