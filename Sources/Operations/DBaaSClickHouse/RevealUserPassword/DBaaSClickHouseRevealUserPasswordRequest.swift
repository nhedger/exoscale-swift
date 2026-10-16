import Foundation

extension DBaaSClickHouseOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-clickhouse/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
