import Foundation

/// Response for listing templates.
struct ListTemplatesData: Decodable, Sendable {
    let templates: [Exoscale.Template.Payload]
}
