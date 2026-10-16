import Foundation

extension InstancesOperations.Console {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/console/\(id)"
            )
        }
    }
}
