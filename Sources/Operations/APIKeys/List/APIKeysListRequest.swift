import Foundation

extension APIKeysOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/api-key"
            )
        }
    }
}
