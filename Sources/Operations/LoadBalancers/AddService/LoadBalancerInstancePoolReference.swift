import Foundation

/// Instance pool reference used by network load balancer service request bodies.
struct LoadBalancerInstancePoolReference: Encodable, Sendable {
    let id: String
}
