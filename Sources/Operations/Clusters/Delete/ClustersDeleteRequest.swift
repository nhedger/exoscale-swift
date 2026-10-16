import Foundation

extension ClustersOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/sks-cluster/\(id)"
            )
        }
    }
}
