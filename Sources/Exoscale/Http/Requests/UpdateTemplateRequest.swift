/// Request body for updating template attributes.
struct UpdateTemplateRequest: Codable, Sendable {
    let name: String?
    let description: String?
}
