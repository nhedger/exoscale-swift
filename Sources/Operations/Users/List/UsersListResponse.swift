import Foundation

extension UsersOperations.List {
    struct Response: HttpResponse {
        let data: ListUsersData

        func transform(client: Http.Client) -> [Exoscale.User] {
            data.users.map { Exoscale.User(data: $0, client: client) }
        }
    }
}
