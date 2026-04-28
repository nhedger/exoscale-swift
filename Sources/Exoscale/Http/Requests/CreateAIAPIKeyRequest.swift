/// Request body for creating an AI API key.
struct CreateAIAPIKeyRequest: Codable, Sendable {
    let name: String
    let scope: String
}
