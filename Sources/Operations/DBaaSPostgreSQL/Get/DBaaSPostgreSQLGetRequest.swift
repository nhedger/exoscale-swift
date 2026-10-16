import Foundation

extension DBaaSPostgreSQLOperations.Get {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-postgres/\(name)"
            )
        }
    }
}
