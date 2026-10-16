import Foundation

extension Exoscale.DBaaS.ClickHouse.ACLConfig {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let users: [Exoscale.DBaaS.ClickHouse.UserACL.Payload]?
    }
}
