import Foundation

extension DBaaSMySQLOperations.ResetUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let password: String?
        let authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                ResetDBaaSMySQLUserPasswordBody(password: password, authentication: authentication)
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-mysql/\(serviceName)/user/\(username)/password/reset",
                body: body
            )
        }
    }
}
