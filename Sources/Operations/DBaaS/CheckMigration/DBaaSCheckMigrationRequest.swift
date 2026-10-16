import Foundation

extension DBaaSOperations.CheckMigration {
    struct Request: HttpRequest {
        let service: String
        let sourceServiceURI: String
        let method: String?
        let ignoredDatabases: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CheckDBaaSMigrationBody(
                    sourceServiceURI: sourceServiceURI,
                    method: method,
                    ignoredDatabases: ignoredDatabases
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-task-migration-check/\(service)",
                body: body
            )
        }
    }
}
