import Foundation

extension Exoscale.ImpactEstimate {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let impact: Impact
    }

    /// Exoscale's Go SDK spec keys indicators by SKU, while the published spec has a single set of
    /// indicators, so both shapes are accepted.
    enum Impact: Decodable, Sendable {
        case bySKU([String: [String: Exoscale.ImpactValue]])
        case indicators([String: Exoscale.ImpactValue])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let bySKU = try? container.decode([String: [String: Exoscale.ImpactValue]].self) {
                self = .bySKU(bySKU)
            } else {
                self = try .indicators(container.decode([String: Exoscale.ImpactValue].self))
            }
        }
    }
}
