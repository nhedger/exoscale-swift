import Foundation

extension NodepoolsOperations.Get {
    struct Request: HttpRequest {
        let clusterID: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-cluster/\(clusterID)/nodepool/\(id)"
            )
        }
    }
}
