import Foundation

extension DBaaSPostgreSQLOperations.DeleteUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-postgres/\(serviceName)/user/\(username)"
            )
        }
    }
}
