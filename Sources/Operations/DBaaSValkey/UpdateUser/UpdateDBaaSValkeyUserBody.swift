import Foundation

/// Request body for updating a DBaaS Valkey user.
struct UpdateDBaaSValkeyUserBody: Encodable, Sendable {
    let accessControl: Exoscale.DBaaS.Valkey.AccessControl?

    enum CodingKeys: String, CodingKey {
        case accessControl = "access-control"
    }
}
