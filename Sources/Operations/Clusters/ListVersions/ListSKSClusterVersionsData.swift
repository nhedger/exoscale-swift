import Foundation

/// Response for listing SKS cluster versions.
struct ListSKSClusterVersionsData: Decodable, Sendable {
    let versions: [String]

    enum CodingKeys: String, CodingKey {
        case versions = "sks-cluster-versions"
    }
}
