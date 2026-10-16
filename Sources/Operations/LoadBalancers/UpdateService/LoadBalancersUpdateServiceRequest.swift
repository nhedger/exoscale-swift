import Foundation

extension LoadBalancersOperations.UpdateService {
    struct Request: HttpRequest {
        let id: String
        let serviceID: String
        let name: String?
        let description: String?
        let networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol?
        let strategy: Exoscale.LoadBalancer.Service.Strategy?
        let port: Int?
        let targetPort: Int?
        let healthcheck: Exoscale.LoadBalancer.Service.Healthcheck?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateLoadBalancerServiceBody(
                    name: name,
                    description: description,
                    networkProtocol: networkProtocol,
                    strategy: strategy,
                    port: port,
                    targetPort: targetPort,
                    healthcheck: healthcheck
                )
            )

            return Http.Request(
                method: .put,
                path: "/load-balancer/\(id)/service/\(serviceID)",
                body: body
            )
        }
    }
}
