import Foundation

extension DBaaSMySQLOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-mysql/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
