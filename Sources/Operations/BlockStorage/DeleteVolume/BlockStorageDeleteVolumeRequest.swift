import Foundation

extension BlockStorageOperations.DeleteVolume {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/block-storage/\(id)"
            )
        }
    }
}
