import Foundation

extension AntiAffinityGroupsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/anti-affinity-group/\(id)"
            )
        }
    }
}
