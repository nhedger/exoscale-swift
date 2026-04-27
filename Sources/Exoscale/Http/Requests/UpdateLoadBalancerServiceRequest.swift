/// Request body for updating a network load balancer service.
struct UpdateLoadBalancerServiceRequest: Codable, Sendable {
    let name: String?
    let description: String?
    let networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol?
    let strategy: Exoscale.LoadBalancer.Service.Strategy?
    let port: Int?
    let targetPort: Int?
    let healthcheck: Exoscale.LoadBalancer.Service.Healthcheck?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case networkProtocol = "protocol"
        case strategy
        case port
        case targetPort = "target-port"
        case healthcheck
    }
}
