import Foundation

extension DBaaSPostgreSQLOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let allowReplication: Bool?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDBaaSPostgreSQLUserBody(username: username, allowReplication: allowReplication)
            )

            return Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(serviceName)/user",
                body: body
            )
        }
    }
}
