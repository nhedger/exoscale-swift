import Foundation

extension DBaaSPostgreSQLOperations.CreateConnectionPool {
    struct Request: HttpRequest {
        let serviceName: String
        let name: String
        let databaseName: String
        let mode: Exoscale.DBaaS.PostgreSQL.PoolMode?
        let size: Int?
        let username: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSPostgreSQLConnectionPoolBody(
                    name: name,
                    databaseName: databaseName,
                    mode: mode,
                    size: size,
                    username: username
                )
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(serviceName)/connection-pool",
                body: body
            )
        }
    }
}
