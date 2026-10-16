import Foundation

extension InstanceTypesOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/instance-type"
            )
        }
    }
}
