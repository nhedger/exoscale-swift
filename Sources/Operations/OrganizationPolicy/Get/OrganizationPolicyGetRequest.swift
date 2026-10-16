import Foundation

extension OrganizationPolicyOperations.Get {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/iam-organization-policy"
            )
        }
    }
}
