import Foundation

extension RolesOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?
        let permissions: [Exoscale.Role.Permission]?
        let editable: Bool?
        let labels: [String: String]?
        let policy: Exoscale.IAMPolicy?
        let assumeRolePolicy: Exoscale.IAMAssumeRolePolicy?
        let maxSessionTTL: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateRoleBody(
                    name: name,
                    description: description,
                    permissions: permissions,
                    editable: editable,
                    labels: labels,
                    policy: policy,
                    assumeRolePolicy: assumeRolePolicy,
                    maxSessionTTL: maxSessionTTL
                )
            )

            return Http.Request(
                method: .post,
                path: "/iam-role",
                body: body
            )
        }
    }
}
