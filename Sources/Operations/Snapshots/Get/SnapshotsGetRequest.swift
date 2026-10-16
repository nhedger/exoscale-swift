import Foundation

extension SnapshotsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/snapshot/\(id)"
            )
        }
    }
}
