import Foundation

/// Response for listing AI API keys.
struct ListAIAPIKeysData: Decodable, Sendable {
    let aiAPIKeys: [Exoscale.AIAPIKey.Payload]

    enum CodingKeys: String, CodingKey {
        case aiAPIKeys = "ai-api-keys"
    }
}
