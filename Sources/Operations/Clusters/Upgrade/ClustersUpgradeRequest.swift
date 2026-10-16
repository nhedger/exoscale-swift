import Foundation

extension ClustersOperations.Upgrade {
    struct Request: HttpRequest {
        let id: String
        let version: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpgradeSKSClusterBody(version: version))

            return Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)/upgrade",
                body: body
            )
        }
    }
}
