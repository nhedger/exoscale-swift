import Foundation

extension DBaaSOpenSearchOperations.Settings {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-settings-opensearch"
            )
        }
    }
}
