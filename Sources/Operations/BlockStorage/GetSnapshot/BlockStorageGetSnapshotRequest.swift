import Foundation

extension BlockStorageOperations.GetSnapshot {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/block-storage-snapshot/\(id)"
            )
        }
    }
}
