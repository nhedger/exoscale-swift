import Foundation

extension RolesOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/iam-role"
            )
        }
    }
}
