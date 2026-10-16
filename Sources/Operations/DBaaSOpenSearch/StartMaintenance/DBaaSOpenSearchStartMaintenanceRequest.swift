import Foundation

extension DBaaSOpenSearchOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-opensearch/\(name)/maintenance/start"
            )
        }
    }
}
