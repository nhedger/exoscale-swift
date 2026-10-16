import Foundation

extension DBaaSClickHouseOperations.Settings {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-settings-clickhouse"
            )
        }
    }
}
