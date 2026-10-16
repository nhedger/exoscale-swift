import Foundation

extension DBaaSValkeyOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-valkey/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
