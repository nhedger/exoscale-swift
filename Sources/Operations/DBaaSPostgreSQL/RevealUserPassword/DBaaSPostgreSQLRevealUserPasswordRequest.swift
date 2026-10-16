import Foundation

extension DBaaSPostgreSQLOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-postgres/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
