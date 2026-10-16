import Foundation

extension Exoscale.UsageReport {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let usage: [Entry]
    }
}
