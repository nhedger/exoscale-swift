import Foundation

extension DBaaSMySQLOperations.Get {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-mysql/\(name)"
            )
        }
    }
}
