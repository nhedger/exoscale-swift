/// Response for listing Private Networks.
public struct ListPrivateNetworksResponse: Codable, Sendable {
    public let privateNetworks: [Exoscale.PrivateNetwork]

    enum CodingKeys: String, CodingKey {
        case privateNetworks = "private-networks"
    }
}
