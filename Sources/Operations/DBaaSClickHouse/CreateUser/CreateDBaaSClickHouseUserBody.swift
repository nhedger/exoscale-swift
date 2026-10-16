import Foundation

struct CreateDBaaSClickHouseUserBody: Encodable, Sendable {
    let username: String
    let password: String?
    let roles: [Exoscale.DBaaS.ClickHouse.RoleReference]?
}
