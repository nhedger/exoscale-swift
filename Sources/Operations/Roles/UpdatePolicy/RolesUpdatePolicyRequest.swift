import Foundation

extension RolesOperations.UpdatePolicy {
    struct Request: HttpRequest {
        let id: String
        let policy: Exoscale.IAMPolicy

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(policy)

            return Http.Request(
                method: .put,
                path: "/iam-role/\(id):policy",
                body: body
            )
        }
    }
}
