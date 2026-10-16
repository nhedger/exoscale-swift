import Foundation

extension Exoscale.DBaaS.ClickHouse.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let clickhouse: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}
