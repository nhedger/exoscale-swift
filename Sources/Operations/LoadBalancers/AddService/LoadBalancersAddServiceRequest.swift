import Foundation

extension LoadBalancersOperations.AddService {
    struct Request: HttpRequest {
        let id: String
        let name: String
        let instancePoolID: String
        let networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol
        let strategy: Exoscale.LoadBalancer.Service.Strategy
        let port: Int
        let targetPort: Int
        let healthcheck: Exoscale.LoadBalancer.Service.Healthcheck
        let description: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                AddLoadBalancerServiceBody(
                    name: name,
                    description: description,
                    instancePool: LoadBalancerInstancePoolReference(id: instancePoolID),
                    networkProtocol: networkProtocol,
                    strategy: strategy,
                    port: port,
                    targetPort: targetPort,
                    healthcheck: healthcheck
                )
            )

            return Http.Request(
                method: .post,
                path: "/load-balancer/\(id)/service",
                body: body
            )
        }
    }
}
