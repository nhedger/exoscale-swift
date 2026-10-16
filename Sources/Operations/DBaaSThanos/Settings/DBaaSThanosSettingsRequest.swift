import Foundation

extension DBaaSThanosOperations.Settings {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-settings-thanos"
            )
        }
    }
}
