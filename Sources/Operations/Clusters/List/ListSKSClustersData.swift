import Foundation

/// Response for listing SKS clusters.
struct ListSKSClustersData: Decodable, Sendable {
    let clusters: [Exoscale.SKSCluster.Payload]

    enum CodingKeys: String, CodingKey {
        case clusters = "sks-clusters"
    }
}
