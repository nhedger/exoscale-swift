import Foundation

extension Exoscale.DBaaS.Thanos.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let thanos: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
