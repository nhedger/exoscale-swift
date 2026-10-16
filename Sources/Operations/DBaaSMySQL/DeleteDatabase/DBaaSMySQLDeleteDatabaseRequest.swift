import Foundation

extension DBaaSMySQLOperations.DeleteDatabase {
    struct Request: HttpRequest {
        let serviceName: String
        let databaseName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-mysql/\(serviceName)/database/\(databaseName)"
            )
        }
    }
}
