import Foundation

/// Response for deleting an AI API key.
struct DeleteAIAPIKeyData: Decodable, Sendable {
    let deleted: Bool
}
