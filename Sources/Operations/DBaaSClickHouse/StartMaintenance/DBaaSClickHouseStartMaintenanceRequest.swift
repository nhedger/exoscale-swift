import Foundation

extension DBaaSClickHouseOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-clickhouse/\(name)/maintenance/start"
            )
        }
    }
}
