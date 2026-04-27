/// Response for listing KMS keys.
public struct ListKMSKeysResponse: Codable, Sendable {
    public let kmsKeys: [Exoscale.KMSKey]

    enum CodingKeys: String, CodingKey {
        case kmsKeys = "kms-keys"
    }
}
