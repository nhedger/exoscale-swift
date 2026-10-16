import Foundation

extension SecurityGroupsOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateSecurityGroupBody(name: name, description: description))

            return Http.Request(
                method: .post,
                path: "/security-group",
                body: body
            )
        }
    }
}
