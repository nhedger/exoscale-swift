import Foundation

extension RolesOperations.List {
    struct Response: HttpResponse {
        let data: ListRolesData

        func transform(client: Http.Client) -> [Exoscale.Role] {
            data.roles.map { Exoscale.Role(data: $0, client: client) }
        }
    }
}
