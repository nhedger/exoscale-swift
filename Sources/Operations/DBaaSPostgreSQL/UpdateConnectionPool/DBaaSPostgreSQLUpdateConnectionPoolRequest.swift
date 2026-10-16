import Foundation

extension DBaaSPostgreSQLOperations.UpdateConnectionPool {
    struct Request: HttpRequest {
        let serviceName: String
        let connectionPoolName: String
        let databaseName: String?
        let mode: Exoscale.DBaaS.PostgreSQL.PoolMode?
        let size: Int?
        let username: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSPostgreSQLConnectionPoolBody(
                    databaseName: databaseName,
                    mode: mode,
                    size: size,
                    username: username
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-postgres/\(serviceName)/connection-pool/\(connectionPoolName)",
                body: body
            )
        }
    }
}
