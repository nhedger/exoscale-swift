import Foundation

extension DBaaSOpenSearchOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSOpenSearchUserBody(username: username))

            return Http.Request(
                method: .post,
                path: "/dbaas-opensearch/\(serviceName)/user",
                body: body
            )
        }
    }
}
