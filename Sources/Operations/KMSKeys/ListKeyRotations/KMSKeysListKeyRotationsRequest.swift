import Foundation

extension KMSKeysOperations.ListKeyRotations {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/kms-key/\(id)/list-key-rotations"
            )
        }
    }
}
