import Foundation

extension AIAPIKeysOperations.Rotate {
    struct Response: HttpResponse {
        let data: AIAPIKeyValueData

        func transform(client _: Http.Client) -> String {
            data.value
        }
    }
}
