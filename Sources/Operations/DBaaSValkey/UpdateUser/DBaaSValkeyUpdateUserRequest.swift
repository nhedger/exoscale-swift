import Foundation

extension DBaaSValkeyOperations.UpdateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let accessControl: Exoscale.DBaaS.Valkey.AccessControl?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateDBaaSValkeyUserBody(accessControl: accessControl))

            return Http.Request(
                method: .put,
                path: "/dbaas-valkey/\(serviceName)/user/\(username)",
                body: body
            )
        }
    }
}
