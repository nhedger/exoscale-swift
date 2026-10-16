import Foundation

extension NodepoolsOperations.Delete {
    struct Request: HttpRequest {
        let clusterID: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/sks-cluster/\(clusterID)/nodepool/\(id)"
            )
        }
    }
}
