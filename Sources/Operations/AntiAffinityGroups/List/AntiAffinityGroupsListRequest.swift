import Foundation

extension AntiAffinityGroupsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/anti-affinity-group"
            )
        }
    }
}
