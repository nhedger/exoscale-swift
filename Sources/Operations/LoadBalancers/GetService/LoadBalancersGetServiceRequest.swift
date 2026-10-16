import Foundation

extension LoadBalancersOperations.GetService {
    struct Request: HttpRequest {
        let id: String
        let serviceID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/load-balancer/\(id)/service/\(serviceID)"
            )
        }
    }
}
