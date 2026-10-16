import Foundation

extension DeploymentsOperations.Logs {
    struct Request: HttpRequest {
        let id: String
        let stream: Bool?
        let tail: Int?

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/deployment/\(id)/logs",
                query: [
                    "stream": stream.map { $0 ? "true" : "false" },
                    "tail": tail.map(String.init)
                ]
            )
        }
    }
}
