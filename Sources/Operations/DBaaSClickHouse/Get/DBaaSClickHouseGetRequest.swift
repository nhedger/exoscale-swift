import Foundation

extension DBaaSClickHouseOperations.Get {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-clickhouse/\(name)"
            )
        }
    }
}
