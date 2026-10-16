import Foundation

extension KMSKeysOperations.Disable {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/kms-key/\(id)/disable"
            )
        }
    }
}
