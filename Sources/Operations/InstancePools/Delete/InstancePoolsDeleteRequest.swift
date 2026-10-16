import Foundation

extension InstancePoolsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/instance-pool/\(id)"
            )
        }
    }
}
