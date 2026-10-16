import Foundation

extension AIAPIKeysOperations.Rotate {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/ai/api-key/\(id)/rotate"
            )
        }
    }
}
