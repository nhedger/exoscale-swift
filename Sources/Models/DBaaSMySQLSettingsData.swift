import Foundation

extension Exoscale.DBaaS.MySQL.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let mysql: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
