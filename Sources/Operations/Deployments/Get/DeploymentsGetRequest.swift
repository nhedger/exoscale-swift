import Foundation

extension DeploymentsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/deployment/\(id)"
            )
        }
    }
}
