import Foundation

extension NodepoolsOperations.Scale {
    struct Request: HttpRequest {
        let clusterID: String
        let id: String
        let size: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ScaleSKSNodepoolBody(size: size))

            return Http.Request(
                method: .put,
                path: "/sks-cluster/\(clusterID)/nodepool/\(id):scale",
                body: body
            )
        }
    }
}
