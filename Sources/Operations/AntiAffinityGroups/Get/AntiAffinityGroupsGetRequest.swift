import Foundation

extension AntiAffinityGroupsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/anti-affinity-group/\(id)"
            )
        }
    }
}
