import Foundation

extension Exoscale.DBaaS.PostgreSQL.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let pg: JSONSchema?
        let pglookout: JSONSchema?
        let pgbouncer: JSONSchema?
        let timescaledb: JSONSchema?
    }
}
