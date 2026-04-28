/// Request body for encrypting plaintext with a KMS key.
struct EncryptRequest: Codable, Sendable {
    let encryptionContext: String?
    let plaintext: String

    enum CodingKeys: String, CodingKey {
        case encryptionContext = "encryption-context"
        case plaintext
    }
}
