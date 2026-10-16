import Foundation

/// Request body for creating a DBaaS PostgreSQL user.
struct CreateDBaaSPostgreSQLUserBody: Encodable, Sendable {
    let username: String
    let allowReplication: Bool?

    enum CodingKeys: String, CodingKey {
        case username
        case allowReplication = "allow-replication"
    }
}
