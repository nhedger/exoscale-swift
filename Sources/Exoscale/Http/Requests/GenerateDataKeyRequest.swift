/// Request body for generating a KMS data key.
struct GenerateDataKeyRequest: Codable, Sendable {
    let keySpec: Exoscale.CryptoDataKey.KeySpec?
    let bytesCount: Int?
    let encryptionContext: String?

    enum CodingKeys: String, CodingKey {
        case keySpec = "key-spec"
        case bytesCount = "bytes-count"
        case encryptionContext = "encryption-context"
    }
}
