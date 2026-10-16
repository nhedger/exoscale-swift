import Foundation

extension DomainsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dns-domain/\(id)"
            )
        }
    }
}
