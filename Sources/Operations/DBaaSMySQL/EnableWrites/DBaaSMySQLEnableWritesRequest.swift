import Foundation

extension DBaaSMySQLOperations.EnableWrites {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-mysql/\(name)/enable/writes"
            )
        }
    }
}
