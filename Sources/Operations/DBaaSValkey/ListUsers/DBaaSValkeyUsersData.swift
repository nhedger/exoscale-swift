import Foundation

/// Response for listing DBaaS Valkey users.
struct DBaaSValkeyUsersData: Decodable, Sendable {
    let users: [Exoscale.DBaaS.Valkey.User.Payload]
}
