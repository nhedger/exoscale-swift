/// Request body for creating a network load balancer.
struct CreateLoadBalancerRequest: Codable, Sendable {
    let name: String
    let description: String?
    let labels: [String: String]?
}
