import Foundation

extension Exoscale.DBaaS.Valkey.User {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String?
        let type: String?
        let accessControl: Exoscale.DBaaS.Valkey.AccessControl?
    }
}

extension Exoscale.DBaaS.Valkey.User.Payload {
    enum CodingKeys: String, CodingKey {
        case username
        case type
        case accessControl = "access-control"
    }
}
