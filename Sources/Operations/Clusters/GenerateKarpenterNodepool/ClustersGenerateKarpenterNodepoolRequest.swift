import Foundation

extension ClustersOperations.GenerateKarpenterNodepool {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)/generate-karpenter-nodepool"
            )
        }
    }
}
