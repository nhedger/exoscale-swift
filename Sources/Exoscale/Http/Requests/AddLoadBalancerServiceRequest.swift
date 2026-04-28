/// Request body for adding a service to a network load balancer.
struct AddLoadBalancerServiceRequest: Codable, Sendable {
    let name: String
    let description: String?
    let instancePool: LoadBalancerInstancePoolReference
    let networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol
    let strategy: Exoscale.LoadBalancer.Service.Strategy
    let port: Int
    let targetPort: Int
    let healthcheck: Exoscale.LoadBalancer.Service.Healthcheck

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case instancePool = "instance-pool"
        case networkProtocol = "protocol"
        case strategy
        case port
        case targetPort = "target-port"
        case healthcheck
    }
}

/// Instance pool reference used by network load balancer service request bodies.
struct LoadBalancerInstancePoolReference: Codable, Sendable {
    let id: String
}
