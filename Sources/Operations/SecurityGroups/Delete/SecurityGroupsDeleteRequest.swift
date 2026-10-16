import Foundation

extension SecurityGroupsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/security-group/\(id)"
            )
        }
    }
}
