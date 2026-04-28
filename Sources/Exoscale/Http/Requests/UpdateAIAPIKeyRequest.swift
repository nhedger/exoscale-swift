/// Request body for updating an AI API key.
struct UpdateAIAPIKeyRequest: Codable, Sendable {
    let name: String?
    let scope: String?
}
