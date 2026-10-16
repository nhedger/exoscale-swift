import Foundation

extension ClustersOperations.GenerateKubeconfig {
    struct Request: HttpRequest {
        let id: String
        let user: String
        let groups: [String]
        let ttl: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                GenerateSKSClusterKubeconfigBody(
                    ttl: ttl,
                    user: user,
                    groups: groups
                )
            )

            return Http.Request(
                method: .post,
                path: "/sks-cluster-kubeconfig/\(id)",
                body: body
            )
        }
    }
}
