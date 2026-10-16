import Foundation

extension RolesOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let description: String?
        let permissions: [Exoscale.Role.Permission]?
        let labels: [String: String]?
        let maxSessionTTL: Int?
        let assumeRolePolicy: Exoscale.IAMAssumeRolePolicy?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateRoleBody(
                    description: description,
                    permissions: permissions,
                    labels: labels,
                    maxSessionTTL: maxSessionTTL,
                    assumeRolePolicy: assumeRolePolicy
                )
            )

            return Http.Request(
                method: .put,
                path: "/iam-role/\(id)",
                body: body
            )
        }
    }
}
