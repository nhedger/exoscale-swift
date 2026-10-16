import Foundation

extension DeployTargetsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/deploy-target/\(id)"
            )
        }
    }
}
