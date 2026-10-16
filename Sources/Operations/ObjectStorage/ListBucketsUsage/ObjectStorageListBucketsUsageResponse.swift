import Foundation

extension ObjectStorageOperations.ListBucketsUsage {
    struct Response: HttpResponse {
        let data: ListSOSBucketsUsageData

        func transform(client: Http.Client) -> [Exoscale.SOSBucketUsage] {
            data.sosBucketsUsage.map { Exoscale.SOSBucketUsage(data: $0, client: client) }
        }
    }
}
