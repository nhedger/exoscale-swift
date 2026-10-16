import Foundation

extension APIKeysOperations.List {
    struct Response: HttpResponse {
        let data: ListAPIKeysData

        func transform(client: Http.Client) -> [Exoscale.APIKey] {
            data.apiKeys.map { Exoscale.APIKey(data: $0, client: client) }
        }
    }
}
