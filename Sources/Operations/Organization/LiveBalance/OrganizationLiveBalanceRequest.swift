import Foundation

extension OrganizationOperations.LiveBalance {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/live-balance"
            )
        }
    }
}
