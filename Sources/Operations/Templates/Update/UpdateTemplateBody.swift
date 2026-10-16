import Foundation

/// Request body for updating template attributes.
struct UpdateTemplateBody: Encodable, Sendable {
    let name: String?
    let description: String?
}
