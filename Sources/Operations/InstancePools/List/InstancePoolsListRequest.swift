import Foundation

extension InstancePoolsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/instance-pool"
            )
        }
    }
}
