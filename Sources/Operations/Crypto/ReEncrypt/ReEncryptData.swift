import Foundation

/// Response for re-encrypting ciphertext with a KMS key.
struct ReEncryptData: Decodable, Sendable {
    let ciphertext: String
}
