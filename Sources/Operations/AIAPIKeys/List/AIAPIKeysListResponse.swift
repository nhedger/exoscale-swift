import Foundation

extension AIAPIKeysOperations.List {
    struct Response: HttpResponse {
        let data: ListAIAPIKeysData

        func transform(client: Http.Client) -> [Exoscale.AIAPIKey] {
            data.aiAPIKeys.map { Exoscale.AIAPIKey(data: $0, client: client) }
        }
    }
}
