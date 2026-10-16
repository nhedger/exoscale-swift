import Foundation

extension ModelsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/model"
            )
        }
    }
}
