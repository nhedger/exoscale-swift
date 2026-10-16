import Foundation

extension DBaaSMySQLOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSMySQLUserBody(
                username: username,
                authentication: authentication
            ))

            return Http.Request(
                method: .post,
                path: "/dbaas-mysql/\(serviceName)/user",
                body: body
            )
        }
    }
}
