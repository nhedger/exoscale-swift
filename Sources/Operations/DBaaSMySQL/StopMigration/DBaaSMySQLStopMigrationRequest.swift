import Foundation

extension DBaaSMySQLOperations.StopMigration {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/dbaas-mysql/\(name)/migration/stop"
            )
        }
    }
}
