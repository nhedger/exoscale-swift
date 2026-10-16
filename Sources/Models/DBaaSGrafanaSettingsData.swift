import Foundation

extension Exoscale.DBaaS.Grafana.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let grafana: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
