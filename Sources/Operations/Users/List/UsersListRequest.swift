import Foundation

extension UsersOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/user"
            )
        }
    }
}
