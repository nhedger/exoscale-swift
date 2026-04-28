/// Response for listing AI API keys.
public struct ListAIAPIKeysResponse: Codable, Sendable {
    public let aiAPIKeys: [Exoscale.AIAPIKey]

    enum CodingKeys: String, CodingKey {
        case aiAPIKeys = "ai-api-keys"
    }
}
