import Foundation

extension DBaaSValkeyOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let accessControl: Exoscale.DBaaS.Valkey.AccessControl?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSValkeyUserBody(
                username: username,
                accessControl: accessControl
            ))

            return Http.Request(
                method: .post,
                path: "/dbaas-valkey/\(serviceName)/user",
                body: body
            )
        }
    }
}
