import Foundation

/// Response for revealing an AI deployment API key.
struct RevealDeploymentAPIKeyData: Decodable, Sendable {
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case apiKey = "api-key"
    }
}
