import Foundation

extension DBaaSPostgreSQLOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-postgres/\(name)/maintenance/start"
            )
        }
    }
}
