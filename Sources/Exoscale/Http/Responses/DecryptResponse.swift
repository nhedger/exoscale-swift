/// Response for decrypting ciphertext with a KMS key.
public struct DecryptResponse: Codable, Sendable {
    public let plaintext: String
}
