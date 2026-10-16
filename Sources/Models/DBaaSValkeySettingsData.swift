import Foundation

extension Exoscale.DBaaS.Valkey.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let valkey: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
