import Foundation

/// Request body for creating a DBaaS MySQL database.
struct CreateDBaaSMySQLDatabaseBody: Encodable, Sendable {
    let databaseName: String

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
    }
}
