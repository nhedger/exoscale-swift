import Foundation

extension ModelsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/model/\(id)"
            )
        }
    }
}
