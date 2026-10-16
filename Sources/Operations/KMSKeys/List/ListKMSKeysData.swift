import Foundation

/// Response for listing KMS keys.
struct ListKMSKeysData: Decodable, Sendable {
    let kmsKeys: [Exoscale.KMSKey.Payload]

    enum CodingKeys: String, CodingKey {
        case kmsKeys = "kms-keys"
    }
}
