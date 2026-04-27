/// Request body for copying a template to another zone.
struct CopyTemplateRequest: Codable, Sendable {
    let targetZone: TemplateZoneReference

    enum CodingKeys: String, CodingKey {
        case targetZone = "target-zone"
    }
}

/// Zone reference used by template request bodies.
struct TemplateZoneReference: Codable, Sendable {
    let name: Exoscale.KnownZone
}
