import Foundation

struct ListDBaaSClickHouseUsersData: Decodable, Sendable {
    let users: [Exoscale.DBaaS.ClickHouse.User.Payload]
}
