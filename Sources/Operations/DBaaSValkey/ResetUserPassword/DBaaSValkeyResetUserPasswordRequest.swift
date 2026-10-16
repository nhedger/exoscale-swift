import Foundation

extension DBaaSValkeyOperations.ResetUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let password: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ResetDBaaSUserPasswordBody(password: password))

            return Http.Request(
                method: .put,
                path: "/dbaas-valkey/\(serviceName)/user/\(username)/password/reset",
                body: body
            )
        }
    }
}
