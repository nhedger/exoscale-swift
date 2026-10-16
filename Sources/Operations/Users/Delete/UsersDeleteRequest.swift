import Foundation

extension UsersOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/user/\(id)"
            )
        }
    }
}
