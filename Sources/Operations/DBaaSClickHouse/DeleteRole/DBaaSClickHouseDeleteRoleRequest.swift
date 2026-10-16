import Foundation

extension DBaaSClickHouseOperations.DeleteRole {
    struct Request: HttpRequest {
        let serviceName: String
        let roleUUID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-clickhouse/\(serviceName)/role/\(roleUUID)"
            )
        }
    }
}
