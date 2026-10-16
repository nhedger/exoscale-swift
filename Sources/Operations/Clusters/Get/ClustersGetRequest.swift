import Foundation

extension ClustersOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-cluster/\(id)"
            )
        }
    }
}
