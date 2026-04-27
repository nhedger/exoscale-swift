/// Response for re-encrypting ciphertext with a KMS key.
public struct ReEncryptResponse: Codable, Sendable {
    public let ciphertext: String
}
