import Foundation

extension AIAPIKeysOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/api-key"
            )
        }
    }
}
