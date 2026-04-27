/// Response for revealing an AI deployment API key.
public struct RevealDeploymentAPIKeyResponse: Codable, Sendable {
    public let apiKey: String

    enum CodingKeys: String, CodingKey {
        case apiKey = "api-key"
    }
}
