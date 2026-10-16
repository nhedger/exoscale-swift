import Foundation

extension KMSKeysOperations.ScheduleDeletion {
    struct Response: HttpResponse {
        let data: ScheduleKMSKeyDeletionData

        func transform(client _: Http.Client) -> Date {
            data.deleteAt
        }
    }
}
