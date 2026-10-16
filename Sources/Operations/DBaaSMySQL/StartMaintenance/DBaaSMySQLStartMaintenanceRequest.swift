import Foundation

extension DBaaSMySQLOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-mysql/\(name)/maintenance/start"
            )
        }
    }
}
