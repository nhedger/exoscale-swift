import Foundation

extension DBaaSMySQLOperations.CreateDatabase {
    struct Request: HttpRequest {
        let serviceName: String
        let databaseName: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSMySQLDatabaseBody(databaseName: databaseName))

            return Http.Request(
                method: .post,
                path: "/dbaas-mysql/\(serviceName)/database",
                body: body
            )
        }
    }
}
