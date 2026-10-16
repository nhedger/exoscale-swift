import Foundation

extension DomainsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dns-domain"
            )
        }
    }
}
