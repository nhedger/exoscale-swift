import Foundation

extension KMSKeysOperations.DisableKeyRotation {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/kms-key/\(id)/disable-key-rotation"
            )
        }
    }
}
