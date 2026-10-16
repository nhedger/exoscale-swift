import Foundation

/// Response for encrypting plaintext with a KMS key.
struct EncryptData: Decodable, Sendable {
    let ciphertext: String
}
