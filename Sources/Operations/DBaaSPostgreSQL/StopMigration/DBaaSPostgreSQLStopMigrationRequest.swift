import Foundation

extension DBaaSPostgreSQLOperations.StopMigration {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(name)/migration/stop"
            )
        }
    }
}
