import Foundation

extension LoadBalancersOperations.ResetServiceField {
    struct Request: HttpRequest {
        let id: String
        let serviceID: String
        let field: LoadBalancersResource.ServiceField

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/load-balancer/\(id)/service/\(serviceID)/\(field.rawValue)"
            )
        }
    }
}
