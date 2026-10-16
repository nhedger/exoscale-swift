import Foundation

extension DBaaSMySQLOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-mysql/\(name)"
            )
        }
    }
}
