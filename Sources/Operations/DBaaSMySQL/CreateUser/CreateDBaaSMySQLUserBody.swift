import Foundation

/// Request body for creating a DBaaS MySQL user.
struct CreateDBaaSMySQLUserBody: Encodable, Sendable {
    let username: String
    let authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin?
}
