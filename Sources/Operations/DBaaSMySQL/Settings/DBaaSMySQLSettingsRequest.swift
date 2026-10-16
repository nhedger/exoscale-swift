import Foundation

extension DBaaSMySQLOperations.Settings {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-settings-mysql"
            )
        }
    }
}
