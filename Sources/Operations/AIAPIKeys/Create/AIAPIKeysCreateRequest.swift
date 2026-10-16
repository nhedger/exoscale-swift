import Foundation

extension AIAPIKeysOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let scope: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateAIAPIKeyBody(name: name, scope: scope))

            return Http.Request(
                method: .post,
                path: "/ai/api-key",
                body: body
            )
        }
    }
}
