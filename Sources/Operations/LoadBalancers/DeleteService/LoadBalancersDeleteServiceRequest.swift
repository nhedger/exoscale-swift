import Foundation

extension LoadBalancersOperations.DeleteService {
    struct Request: HttpRequest {
        let id: String
        let serviceID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/load-balancer/\(id)/service/\(serviceID)"
            )
        }
    }
}
