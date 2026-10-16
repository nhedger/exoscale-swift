import Foundation

extension SnapshotsOperations.Export {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/snapshot/\(id):export"
            )
        }
    }
}
