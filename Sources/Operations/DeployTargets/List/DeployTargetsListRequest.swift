import Foundation

extension DeployTargetsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/deploy-target"
            )
        }
    }
}
