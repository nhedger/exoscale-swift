import Foundation

extension OrganizationPolicyOperations.Update {
    struct Request: HttpRequest {
        let policy: Exoscale.IAMPolicy

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(policy)

            return Http.Request(
                method: .put,
                path: "/iam-organization-policy",
                body: body
            )
        }
    }
}
