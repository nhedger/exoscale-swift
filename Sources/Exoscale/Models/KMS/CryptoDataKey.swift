public extension Exoscale {
    /// KMS data key returned by the crypto API.
    struct CryptoDataKey: Codable, Sendable {
        public enum KeySpec: String, Codable, Sendable {
            case aes256 = "AES-256"
        }

        public let plaintext: String
        public let ciphertext: String
    }
}
