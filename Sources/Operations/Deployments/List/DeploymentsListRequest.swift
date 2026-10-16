import Foundation

extension DeploymentsOperations.List {
    struct Request: HttpRequest {
        let visibility: String?

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/deployment",
                query: ["visibility": visibility]
            )
        }
    }
}
