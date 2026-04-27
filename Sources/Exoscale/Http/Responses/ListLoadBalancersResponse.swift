/// Response for listing network load balancers.
public struct ListLoadBalancersResponse: Codable, Sendable {
    public let loadBalancers: [Exoscale.LoadBalancer]

    enum CodingKeys: String, CodingKey {
        case loadBalancers = "load-balancers"
    }
}
