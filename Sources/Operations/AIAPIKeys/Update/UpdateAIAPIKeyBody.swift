import Foundation

/// Request body for updating an AI API key.
struct UpdateAIAPIKeyBody: Encodable, Sendable {
    let name: String?
    let scope: String?
}
