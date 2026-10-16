import Foundation

extension Exoscale.DBaaS.OpenSearch.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let opensearch: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
