import Foundation

extension BlockStorageOperations.ListSnapshots {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/block-storage-snapshot"
            )
        }
    }
}
