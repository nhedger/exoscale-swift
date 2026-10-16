import Foundation

/// Request body for updating a DBaaS PostgreSQL connection pool.
struct UpdateDBaaSPostgreSQLConnectionPoolBody: Encodable, Sendable {
    let databaseName: String?
    let mode: Exoscale.DBaaS.PostgreSQL.PoolMode?
    let size: Int?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
        case mode
        case size
        case username
    }
}
