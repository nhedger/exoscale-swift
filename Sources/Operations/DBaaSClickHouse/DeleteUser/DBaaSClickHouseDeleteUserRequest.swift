import Foundation

extension DBaaSClickHouseOperations.DeleteUser {
    struct Request: HttpRequest {
        let serviceName: String
        let userUUID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-clickhouse/\(serviceName)/user/\(userUUID)"
            )
        }
    }
}
