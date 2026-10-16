import Foundation

extension DeploymentsOperations.RevealAPIKey {
    struct Response: HttpResponse {
        let data: RevealDeploymentAPIKeyData

        func transform(client _: Http.Client) -> String {
            data.apiKey
        }
    }
}
