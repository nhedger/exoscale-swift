import Foundation

extension VPCsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/vpc/\(id)"
            )
        }
    }
}
