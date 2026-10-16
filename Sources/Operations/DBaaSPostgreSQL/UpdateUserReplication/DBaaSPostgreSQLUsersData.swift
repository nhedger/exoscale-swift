import Foundation

/// Response for updating DBaaS PostgreSQL users.
struct DBaaSPostgreSQLUsersData: Decodable, Sendable {
    let users: [Exoscale.DBaaS.PostgreSQL.User.Payload]
}
