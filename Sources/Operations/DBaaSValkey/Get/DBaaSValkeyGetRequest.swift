import Foundation

extension DBaaSValkeyOperations.Get {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-valkey/\(name)"
            )
        }
    }
}
