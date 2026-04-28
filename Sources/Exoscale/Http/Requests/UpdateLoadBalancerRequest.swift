/// Request body for updating a network load balancer.
struct UpdateLoadBalancerRequest: Codable, Sendable {
    let name: String?
    let description: String?
    let labels: [String: String]?
}
