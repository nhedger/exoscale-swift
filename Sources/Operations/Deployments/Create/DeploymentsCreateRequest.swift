import Foundation

extension DeploymentsOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let model: Exoscale.AIDeployment.ModelReference
        let gpuType: String
        let gpuCount: Int
        let replicas: Int
        let inferenceEngineVersion: String?
        let inferenceEngineParameters: [String]?
        let productName: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateDeploymentBody(
                    gpuCount: gpuCount,
                    inferenceEngineVersion: inferenceEngineVersion,
                    name: name,
                    gpuType: gpuType,
                    replicas: replicas,
                    inferenceEngineParameters: inferenceEngineParameters,
                    model: model,
                    productName: productName
                )
            )

            return Http.Request(
                method: .post,
                path: "/ai/deployment",
                body: body
            )
        }
    }
}
