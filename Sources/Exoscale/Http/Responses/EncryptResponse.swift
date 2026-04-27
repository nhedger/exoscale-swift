/// Response for encrypting plaintext with a KMS key.
public struct EncryptResponse: Codable, Sendable {
    public let ciphertext: String
}
