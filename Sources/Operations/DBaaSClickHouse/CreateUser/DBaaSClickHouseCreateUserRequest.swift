import Foundation

extension DBaaSClickHouseOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String
        let password: String?
        let roles: [Exoscale.DBaaS.ClickHouse.RoleReference]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSClickHouseUserBody(
                username: username,
                password: password,
                roles: roles
            ))

            return Http.Request(
                method: .post,
                path: "/dbaas-clickhouse/\(serviceName)/user",
                body: body
            )
        }
    }
}
