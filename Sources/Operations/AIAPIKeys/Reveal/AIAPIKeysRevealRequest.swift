import Foundation

extension AIAPIKeysOperations.Reveal {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/api-key/\(id)/reveal"
            )
        }
    }
}
