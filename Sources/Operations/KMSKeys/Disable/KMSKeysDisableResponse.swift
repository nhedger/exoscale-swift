import Foundation

extension KMSKeysOperations.Disable {
    struct Response: HttpResponse {
        let data: KMSKeyActionData

        func transform(client _: Http.Client) -> Exoscale.KMSKey.ActionStatus {
            data.status
        }
    }
}
