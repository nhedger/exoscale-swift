import Foundation

extension VPCsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/vpc"
            )
        }
    }
}
