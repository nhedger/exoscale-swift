import Foundation

extension DBaaSPostgreSQLOperations.UpdateUserReplication {
    struct Response: HttpResponse {
        let data: DBaaSPostgreSQLUsersData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.PostgreSQL.User] {
            data.users.map { Exoscale.DBaaS.PostgreSQL.User(data: $0, client: client) }
        }
    }
}
