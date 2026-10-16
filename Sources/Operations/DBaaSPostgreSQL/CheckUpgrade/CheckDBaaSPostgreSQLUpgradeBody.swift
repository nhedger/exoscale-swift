import Foundation

/// Request body for checking a DBaaS PostgreSQL upgrade.
struct CheckDBaaSPostgreSQLUpgradeBody: Encodable, Sendable {
    let targetVersion: String

    enum CodingKeys: String, CodingKey {
        case targetVersion = "target-version"
    }
}
