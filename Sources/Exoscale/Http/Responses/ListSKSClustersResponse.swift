/// Response for listing SKS clusters.
public struct ListSKSClustersResponse: Codable, Sendable {
    public let clusters: [Exoscale.SKSCluster]

    enum CodingKeys: String, CodingKey {
        case clusters = "sks-clusters"
    }
}
