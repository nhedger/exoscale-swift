import Foundation

/// Request body for updating a network load balancer.
struct UpdateLoadBalancerBody: Encodable, Sendable {
    let name: String?
    let description: String?
    let labels: [String: String]?
}
