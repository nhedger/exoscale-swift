import Foundation

extension AIAPIKeysOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let scope: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateAIAPIKeyBody(name: name, scope: scope))

            return Http.Request(
                method: .patch,
                path: "/ai/api-key/\(id)",
                body: body
            )
        }
    }
}
