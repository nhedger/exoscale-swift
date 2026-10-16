import Foundation

extension DBaaSClickHouseOperations.ListUsers {
    struct Response: HttpResponse {
        let data: ListDBaaSClickHouseUsersData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ClickHouse.User] {
            data.users.map { Exoscale.DBaaS.ClickHouse.User(data: $0, client: client) }
        }
    }
}
