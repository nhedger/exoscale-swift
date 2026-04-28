/// Response for listing SKS cluster versions.
public struct ListSKSClusterVersionsResponse: Codable, Sendable {
    public let versions: [String]

    enum CodingKeys: String, CodingKey {
        case versions = "sks-cluster-versions"
    }
}
