import Foundation

extension OrganizationOperations.EnvImpact {
    struct Request: HttpRequest {
        let period: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/env-impact/\(period)"
            )
        }
    }
}
