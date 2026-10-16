import Foundation

extension DBaaSOpenSearchOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-opensearch/\(name)"
            )
        }
    }
}
