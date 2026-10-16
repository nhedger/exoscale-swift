import Foundation

extension OrganizationPolicyOperations.Reset {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/iam-organization-policy:reset"
            )
        }
    }
}
