import Foundation

/// Request body for creating an AI API key.
struct CreateAIAPIKeyBody: Encodable, Sendable {
    let name: String
    let scope: String
}
