import Foundation

extension LoadBalancersOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateLoadBalancerBody(
                    name: name,
                    description: description,
                    labels: labels
                )
            )

            return Http.Request(
                method: .post,
                path: "/load-balancer",
                body: body
            )
        }
    }
}
