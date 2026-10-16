import Foundation

extension Exoscale.DBaaS.ClickHouse.Role {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String
        let uuid: String?
        let privileges: [[String: Exoscale.JSONValue]]?
        let grantedRoles: [[String: Exoscale.JSONValue]]?
    }
}

extension Exoscale.DBaaS.ClickHouse.Role.Payload {
    enum CodingKeys: String, CodingKey {
        case name, uuid, privileges
        case grantedRoles = "granted-roles"
    }
}
