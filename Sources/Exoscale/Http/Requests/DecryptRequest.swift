/// Request body for decrypting ciphertext with a KMS key.
struct DecryptRequest: Codable, Sendable {
    let encryptionContext: String?
    let ciphertext: String

    enum CodingKeys: String, CodingKey {
        case encryptionContext = "encryption-context"
        case ciphertext
    }
}
