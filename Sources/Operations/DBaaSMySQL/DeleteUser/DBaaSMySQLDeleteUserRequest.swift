import Foundation

extension DBaaSMySQLOperations.DeleteUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-mysql/\(serviceName)/user/\(username)"
            )
        }
    }
}
