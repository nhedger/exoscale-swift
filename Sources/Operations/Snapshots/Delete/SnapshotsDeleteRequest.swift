import Foundation

extension SnapshotsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/snapshot/\(id)"
            )
        }
    }
}
