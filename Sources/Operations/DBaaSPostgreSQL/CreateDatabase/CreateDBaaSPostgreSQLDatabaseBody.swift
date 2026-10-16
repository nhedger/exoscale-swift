import Foundation

/// Request body for creating a DBaaS PostgreSQL database.
struct CreateDBaaSPostgreSQLDatabaseBody: Encodable, Sendable {
    let databaseName: String
    let lcCollate: String?
    let lcCType: String?

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
        case lcCollate = "lc-collate"
        case lcCType = "lc-ctype"
    }
}
