import Foundation

extension KMSKeysOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/kms-key/\(id)"
            )
        }
    }
}
