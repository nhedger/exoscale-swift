import Foundation

/// Response for listing network load balancers.
struct ListLoadBalancersData: Decodable, Sendable {
    let loadBalancers: [Exoscale.LoadBalancer.Payload]

    enum CodingKeys: String, CodingKey {
        case loadBalancers = "load-balancers"
    }
}
