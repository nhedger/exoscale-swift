import Foundation

extension AIAPIKeysOperations.Delete {
    struct Response: HttpResponse {
        let data: DeleteAIAPIKeyData

        func transform(client _: Http.Client) -> Bool {
            data.deleted
        }
    }
}
