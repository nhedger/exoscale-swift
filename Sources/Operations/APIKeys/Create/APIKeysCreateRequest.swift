import Foundation

extension APIKeysOperations.Create {
    struct Request: HttpRequest {
        let roleID: String
        let name: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateAPIKeyBody(roleID: roleID, name: name))

            return Http.Request(
                method: .post,
                path: "/api-key",
                body: body
            )
        }
    }
}
