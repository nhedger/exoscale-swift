import Foundation

/// Response for listing zones.
struct ListZonesData: Decodable, Sendable {
    let zones: [Exoscale.Zone.Payload]
}
