import Foundation

/// Response for listing IAM API keys.
struct ListAPIKeysData: Decodable, Sendable {
    let apiKeys: [Exoscale.APIKey.Payload]

    enum CodingKeys: String, CodingKey {
        case apiKeys = "api-keys"
    }
}
