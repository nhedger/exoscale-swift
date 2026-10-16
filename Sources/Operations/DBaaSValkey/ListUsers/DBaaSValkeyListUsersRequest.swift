import Foundation

extension DBaaSValkeyOperations.ListUsers {
    struct Request: HttpRequest {
        let serviceName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-valkey/\(serviceName)/user"
            )
        }
    }
}
