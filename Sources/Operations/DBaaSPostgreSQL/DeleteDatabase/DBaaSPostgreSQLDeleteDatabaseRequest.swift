import Foundation

extension DBaaSPostgreSQLOperations.DeleteDatabase {
    struct Request: HttpRequest {
        let serviceName: String
        let databaseName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-postgres/\(serviceName)/database/\(databaseName)"
            )
        }
    }
}
