import Foundation

/// Request body for creating a DBaaS OpenSearch user.
struct CreateDBaaSOpenSearchUserBody: Encodable, Sendable {
    let username: String
}
