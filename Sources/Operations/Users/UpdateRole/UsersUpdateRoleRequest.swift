import Foundation

extension UsersOperations.UpdateRole {
    struct Request: HttpRequest {
        let id: String
        let roleID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateUserRoleBody(roleID: roleID))

            return Http.Request(
                method: .put,
                path: "/user/\(id)",
                body: body
            )
        }
    }
}
