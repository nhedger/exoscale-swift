import Foundation

extension APIKeysOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/api-key/\(id)"
            )
        }
    }
}
