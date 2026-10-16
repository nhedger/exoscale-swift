import Foundation

extension ObjectStorageOperations.PresignedURL {
    struct Request: HttpRequest {
        let bucket: String
        let key: String?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let key {
                query["key"] = key
            }

            return Http.Request(
                method: .get,
                path: "/sos/\(bucket)/presigned-url",
                query: query
            )
        }
    }
}
