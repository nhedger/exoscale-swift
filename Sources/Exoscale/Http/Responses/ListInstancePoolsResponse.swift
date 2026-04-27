/// Response for listing Instance Pools.
public struct ListInstancePoolsResponse: Codable, Sendable {
    public let instancePools: [Exoscale.InstancePool]

    enum CodingKeys: String, CodingKey {
        case instancePools = "instance-pools"
    }
}
