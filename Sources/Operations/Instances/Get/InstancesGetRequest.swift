import Foundation

extension InstancesOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/instance/\(id)"
            )
        }
    }
}
