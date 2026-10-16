import Foundation

extension AIAPIKeysOperations.Reveal {
    struct Response: HttpResponse {
        let data: AIAPIKeyValueData

        func transform(client _: Http.Client) -> String {
            data.value
        }
    }
}
