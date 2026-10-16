import Foundation

extension Exoscale.EnvImpactReport {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let metadata: [MetadataEntry]?
        let products: [Product]?
    }
}
