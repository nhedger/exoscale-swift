import Foundation

extension BlockStorageOperations.DeleteSnapshot {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/block-storage-snapshot/\(id)"
            )
        }
    }
}
