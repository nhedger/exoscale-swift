import Foundation

extension DBaaSPostgreSQLOperations.CreateDatabase {
    struct Request: HttpRequest {
        let serviceName: String
        let databaseName: String
        let lcCollate: String?
        let lcCType: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSPostgreSQLDatabaseBody(databaseName: databaseName, lcCollate: lcCollate, lcCType: lcCType)
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(serviceName)/database",
                body: body
            )
        }
    }
}
