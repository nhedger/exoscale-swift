import Foundation

extension SnapshotsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/snapshot"
            )
        }
    }
}
