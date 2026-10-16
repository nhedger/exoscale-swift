import Foundation

/// Request body for updating DBaaS PostgreSQL user replication access.
struct UpdateDBaaSPostgreSQLUserReplicationBody: Encodable, Sendable {
    let allowReplication: Bool

    enum CodingKeys: String, CodingKey {
        case allowReplication = "allow-replication"
    }
}
