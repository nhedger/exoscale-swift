import Foundation

extension OrganizationOperations.Get {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/organization"
            )
        }
    }
}
