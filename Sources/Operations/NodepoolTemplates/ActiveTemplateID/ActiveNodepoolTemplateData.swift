import Foundation

/// Response for retrieving an active SKS nodepool template.
struct ActiveNodepoolTemplateData: Decodable, Sendable {
    let activeTemplate: String

    enum CodingKeys: String, CodingKey {
        case activeTemplate = "active-template"
    }
}
