import Foundation

extension Exoscale.ImpactBreakdown {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let impact: [String: Exoscale.ImpactValue]
        let zones: [String: ZoneImpact]
    }
}
