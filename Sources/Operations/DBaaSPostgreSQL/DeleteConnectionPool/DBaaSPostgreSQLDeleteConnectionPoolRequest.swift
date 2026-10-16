import Foundation

extension DBaaSPostgreSQLOperations.DeleteConnectionPool {
    struct Request: HttpRequest {
        let serviceName: String
        let connectionPoolName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-postgres/\(serviceName)/connection-pool/\(connectionPoolName)"
            )
        }
    }
}
