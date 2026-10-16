import Foundation

/// Request body for copying a template to another zone.
struct CopyTemplateBody: Encodable, Sendable {
    let targetZone: TemplateZoneReference

    enum CodingKeys: String, CodingKey {
        case targetZone = "target-zone"
    }
}
