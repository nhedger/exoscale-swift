import Foundation

extension LoadBalancersOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/load-balancer/\(id)"
            )
        }
    }
}
