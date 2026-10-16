import Foundation

/// Request body for checking a DBaaS migration source.
struct CheckDBaaSMigrationBody: Encodable, Sendable {
    let sourceServiceURI: String
    let method: String?
    let ignoredDatabases: String?

    enum CodingKeys: String, CodingKey {
        case sourceServiceURI = "source-service-uri"
        case method
        case ignoredDatabases = "ignore-dbs"
    }
}
