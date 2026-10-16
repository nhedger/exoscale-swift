import Foundation

/// Request body for resetting a DBaaS MySQL user password.
struct ResetDBaaSMySQLUserPasswordBody: Encodable, Sendable {
    let password: String?
    let authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin?
}
