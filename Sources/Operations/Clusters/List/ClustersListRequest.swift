import Foundation

extension ClustersOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-cluster"
            )
        }
    }
}
