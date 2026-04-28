/// Response for retrieving an active SKS nodepool template.
public struct ActiveNodepoolTemplateResponse: Codable, Sendable {
    public let activeTemplate: String

    enum CodingKeys: String, CodingKey {
        case activeTemplate = "active-template"
    }
}
