import Foundation

extension KMSKeysOperations.Enable {
    struct Response: HttpResponse {
        let data: KMSKeyActionData

        func transform(client _: Http.Client) -> Exoscale.KMSKey.ActionStatus {
            data.status
        }
    }
}
