import Foundation

extension LoadBalancersOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/load-balancer"
            )
        }
    }
}
