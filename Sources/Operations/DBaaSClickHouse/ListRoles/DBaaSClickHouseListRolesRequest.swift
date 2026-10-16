import Foundation

extension DBaaSClickHouseOperations.ListRoles {
    struct Request: HttpRequest {
        let serviceName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-clickhouse/\(serviceName)/role"
            )
        }
    }
}
