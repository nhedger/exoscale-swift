import Foundation

extension LoadBalancersOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/load-balancer/\(id)"
            )
        }
    }
}
