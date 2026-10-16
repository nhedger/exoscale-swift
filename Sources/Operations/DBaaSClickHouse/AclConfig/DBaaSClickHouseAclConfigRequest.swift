import Foundation

extension DBaaSClickHouseOperations.AclConfig {
    struct Request: HttpRequest {
        let serviceName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-clickhouse/\(serviceName)/acl-config"
            )
        }
    }
}
