import Foundation

extension AntiAffinityGroupsOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateAntiAffinityGroupBody(
                    name: name,
                    description: description
                )
            )

            return Http.Request(
                method: .post,
                path: "/anti-affinity-group",
                body: body
            )
        }
    }
}
