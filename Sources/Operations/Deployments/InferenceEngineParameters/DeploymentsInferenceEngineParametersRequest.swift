import Foundation

extension DeploymentsOperations.InferenceEngineParameters {
    struct Request: HttpRequest {
        let version: String?

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/help/inference-engine-parameters",
                query: ["version": version]
            )
        }
    }
}
