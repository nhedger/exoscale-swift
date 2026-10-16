import Foundation

extension DBaaSGrafanaOperations.Settings {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-settings-grafana"
            )
        }
    }
}
