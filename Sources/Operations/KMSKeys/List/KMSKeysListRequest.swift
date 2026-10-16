import Foundation

extension KMSKeysOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/kms-key"
            )
        }
    }
}
