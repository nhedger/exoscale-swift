/// Response for listing templates.
public struct ListTemplatesResponse: Codable, Sendable {
    public let templates: [Exoscale.Template]
}
