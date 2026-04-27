/// Response for listing zones.
public struct ListZonesResponse: Codable, Sendable {
    public let zones: [Exoscale.Zone]
}
