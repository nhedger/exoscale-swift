import Foundation

extension DeploymentsOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let inferenceEngineVersion: String?
        let inferenceEngineParameters: [String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDeploymentBody(
                    inferenceEngineVersion: inferenceEngineVersion,
                    name: name,
                    inferenceEngineParameters: inferenceEngineParameters
                )
            )

            return Http.Request(
                method: .patch,
                path: "/ai/deployment/\(id)",
                body: body
            )
        }
    }
}
