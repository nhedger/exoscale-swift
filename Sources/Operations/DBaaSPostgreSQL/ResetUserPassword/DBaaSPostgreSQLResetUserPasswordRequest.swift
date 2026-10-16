import Foundation

extension DBaaSPostgreSQLOperations.ResetUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let password: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ResetDBaaSPostgreSQLUserPasswordBody(password: password))

            return Http.Request(
                method: .put,
                path: "/dbaas-postgres/\(serviceName)/user/\(username)/password/reset",
                body: body
            )
        }
    }
}
