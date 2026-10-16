import Foundation

/// Request body for resetting a DBaaS PostgreSQL user password.
struct ResetDBaaSPostgreSQLUserPasswordBody: Encodable, Sendable {
    let password: String?
}
