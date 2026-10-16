import Foundation

extension BlockStorageOperations.GetVolume {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/block-storage/\(id)"
            )
        }
    }
}
