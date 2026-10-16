import Foundation

extension LoadBalancersOperations.ResetField {
    struct Request: HttpRequest {
        let id: String
        let field: LoadBalancersResource.Field

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/load-balancer/\(id)/\(field.rawValue)"
            )
        }
    }
}
