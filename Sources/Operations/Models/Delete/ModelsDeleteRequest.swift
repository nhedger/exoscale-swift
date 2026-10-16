import Foundation

extension ModelsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/ai/model/\(id)"
            )
        }
    }
}
