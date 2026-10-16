import Foundation

extension RolesOperations.Assume {
    struct Request: HttpRequest {
        let targetRoleID: String
        let ttl: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(AssumeRoleBody(ttl: ttl))

            return Http.Request(
                method: .post,
                path: "/iam-role/\(targetRoleID)/assume",
                body: body
            )
        }
    }
}
