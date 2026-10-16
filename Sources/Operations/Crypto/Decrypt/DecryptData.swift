import Foundation

/// Response for decrypting ciphertext with a KMS key.
struct DecryptData: Decodable, Sendable {
    let plaintext: String
}
