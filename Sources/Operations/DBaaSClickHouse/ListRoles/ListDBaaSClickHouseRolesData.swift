import Foundation

struct ListDBaaSClickHouseRolesData: Decodable, Sendable {
    let roles: [Exoscale.DBaaS.ClickHouse.Role.Payload]
}
