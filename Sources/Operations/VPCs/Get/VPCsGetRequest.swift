import Foundation

extension VPCsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/vpc/\(id)"
            )
        }
    }
}
