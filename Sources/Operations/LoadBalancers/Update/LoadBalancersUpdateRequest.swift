import Foundation

extension LoadBalancersOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let description: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateLoadBalancerBody(
                    name: name,
                    description: description,
                    labels: labels
                )
            )

            return Http.Request(
                method: .put,
                path: "/load-balancer/\(id)",
                body: body
            )
        }
    }
}
