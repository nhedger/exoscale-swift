import Foundation

extension DBaaSOperations.MigrationStatus {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-migration-status/\(name)"
            )
        }
    }
}
