import Foundation

/// Request body for creating a DBaaS Valkey user.
struct CreateDBaaSValkeyUserBody: Encodable, Sendable {
    let username: String
    let accessControl: Exoscale.DBaaS.Valkey.AccessControl?

    enum CodingKeys: String, CodingKey {
        case username
        case accessControl = "access-control"
    }
}
