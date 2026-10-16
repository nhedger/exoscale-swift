import Foundation

extension SecurityGroupsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/security-group/\(id)"
            )
        }
    }
}
