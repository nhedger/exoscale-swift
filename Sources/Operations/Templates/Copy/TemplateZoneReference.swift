import Foundation

/// Zone reference used by template request bodies.
struct TemplateZoneReference: Encodable, Sendable {
    let name: Exoscale.ZoneName
}
