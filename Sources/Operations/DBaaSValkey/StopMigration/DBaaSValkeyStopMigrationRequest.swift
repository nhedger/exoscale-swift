import Foundation

extension DBaaSValkeyOperations.StopMigration {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/dbaas-valkey/\(name)/migration/stop"
            )
        }
    }
}
