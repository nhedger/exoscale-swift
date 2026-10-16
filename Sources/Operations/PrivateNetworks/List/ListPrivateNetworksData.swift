import Foundation

/// Response for listing Private Networks.
struct ListPrivateNetworksData: Decodable, Sendable {
    let privateNetworks: [Exoscale.PrivateNetwork.Payload]

    enum CodingKeys: String, CodingKey {
        case privateNetworks = "private-networks"
    }
}
