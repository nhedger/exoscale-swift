import Foundation

extension AIAPIKeysOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/ai/api-key/\(id)"
            )
        }
    }
}
