import Foundation

extension BlockStorageOperations.DetachVolume {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/block-storage/\(id):detach"
            )
        }
    }
}
