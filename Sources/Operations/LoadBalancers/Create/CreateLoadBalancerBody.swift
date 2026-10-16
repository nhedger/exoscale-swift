import Foundation

/// Request body for creating a network load balancer.
struct CreateLoadBalancerBody: Encodable, Sendable {
    let name: String
    let description: String?
    let labels: [String: String]?
}
