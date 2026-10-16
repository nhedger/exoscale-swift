import Foundation

extension DeploymentsOperations.Scale {
    struct Request: HttpRequest {
        let id: String
        let replicas: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ScaleDeploymentBody(replicas: replicas))

            return Http.Request(
                method: .post,
                path: "/ai/deployment/\(id)/scale",
                body: body
            )
        }
    }
}
