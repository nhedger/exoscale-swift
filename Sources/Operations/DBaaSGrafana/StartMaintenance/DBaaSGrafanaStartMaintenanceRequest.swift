import Foundation

extension DBaaSGrafanaOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-grafana/\(name)/maintenance/start"
            )
        }
    }
}
