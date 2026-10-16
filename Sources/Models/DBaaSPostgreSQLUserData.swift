import Foundation

extension Exoscale.DBaaS.PostgreSQL.User {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let type: String?
        let username: String?
        let password: String?
        let allowReplication: Bool?
    }
}

extension Exoscale.DBaaS.PostgreSQL.User.Payload {
    enum CodingKeys: String, CodingKey {
        case type
        case username
        case password
        case allowReplication = "allow-replication"
    }
}
