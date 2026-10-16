import Foundation

extension DBaaSValkeyOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-valkey/\(name)/maintenance/start"
            )
        }
    }
}
