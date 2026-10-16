import Foundation

extension ObjectStorageOperations.ListBucketsUsage {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sos-buckets-usage"
            )
        }
    }
}
