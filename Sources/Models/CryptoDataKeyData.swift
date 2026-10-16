import Foundation

extension Exoscale.CryptoDataKey {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let plaintext: String
        let ciphertext: String
    }
}
