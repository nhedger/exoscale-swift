import Foundation

extension RolesOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/iam-role/\(id)"
            )
        }
    }
}
