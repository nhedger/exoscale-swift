import Foundation

extension UsersOperations.Create {
    struct Request: HttpRequest {
        let email: String
        let roleID: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateUserBody(email: email, roleID: roleID))

            return Http.Request(
                method: .post,
                path: "/user",
                body: body
            )
        }
    }
}
