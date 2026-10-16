import Foundation

extension DeploymentsOperations.InferenceEngineParameters {
    struct Response: HttpResponse {
        let data: GetInferenceEngineHelpData

        func transform(client: Http.Client) -> [Exoscale.InferenceEngineParameter] {
            data.parameters.map { Exoscale.InferenceEngineParameter(data: $0, client: client) }
        }
    }
}
