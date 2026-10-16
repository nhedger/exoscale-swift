import Foundation

extension DBaaSClickHouseOperations.ListRoles {
    struct Response: HttpResponse {
        let data: ListDBaaSClickHouseRolesData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ClickHouse.Role] {
            data.roles.map { Exoscale.DBaaS.ClickHouse.Role(data: $0, client: client) }
        }
    }
}
