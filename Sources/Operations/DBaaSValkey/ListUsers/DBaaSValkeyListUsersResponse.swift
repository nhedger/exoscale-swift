import Foundation

extension DBaaSValkeyOperations.ListUsers {
    struct Response: HttpResponse {
        let data: DBaaSValkeyUsersData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.Valkey.User] {
            data.users.map { Exoscale.DBaaS.Valkey.User(data: $0, client: client) }
        }
    }
}
