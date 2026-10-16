import Foundation

/// Request body for creating a DBaaS PostgreSQL connection pool.
struct CreateDBaaSPostgreSQLConnectionPoolBody: Encodable, Sendable {
    let name: String
    let databaseName: String
    let mode: Exoscale.DBaaS.PostgreSQL.PoolMode?
    let size: Int?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case name
        case databaseName = "database-name"
        case mode
        case size
        case username
    }
}
