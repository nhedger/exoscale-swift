import Foundation

extension DBaaSPostgreSQLOperations.UpdateUserReplication {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let allowReplication: Bool

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSPostgreSQLUserReplicationBody(allowReplication: allowReplication)
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-postgres/\(serviceName)/user/\(username)/allow-replication",
                body: body
            )
        }
    }
}
