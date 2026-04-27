/// Response for listing IAM API keys.
public struct ListAPIKeysResponse: Codable, Sendable {
    public let apiKeys: [Exoscale.APIKey]

    enum CodingKeys: String, CodingKey {
        case apiKeys = "api-keys"
    }
}
