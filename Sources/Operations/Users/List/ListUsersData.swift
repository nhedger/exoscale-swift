import Foundation

/// Response for listing organization users.
struct ListUsersData: Decodable, Sendable {
    let users: [Exoscale.User.Payload]
}
