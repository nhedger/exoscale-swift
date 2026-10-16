import Foundation

extension RolesOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/iam-role/\(id)"
            )
        }
    }
}
