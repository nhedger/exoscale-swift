import Foundation

/// Response for listing Instance Pools.
struct ListInstancePoolsData: Decodable, Sendable {
    let instancePools: [Exoscale.InstancePool.Payload]

    enum CodingKeys: String, CodingKey {
        case instancePools = "instance-pools"
    }
}
