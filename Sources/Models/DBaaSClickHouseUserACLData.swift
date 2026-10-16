import Foundation

extension Exoscale.DBaaS.ClickHouse.UserACL {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String
        let uuid: String?
        let roles: [[String: Exoscale.JSONValue]]?
        let privileges: [[String: Exoscale.JSONValue]]?
    }
}
