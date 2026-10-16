import Foundation

extension DBaaSGrafanaOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-grafana/\(name)"
            )
        }
    }
}
