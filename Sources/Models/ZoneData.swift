import Foundation

extension Exoscale.Zone {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: Exoscale.ZoneName
        let apiEndpoint: URL
        let sosEndpoint: URL
    }
}

extension Exoscale.Zone.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case apiEndpoint = "api-endpoint"
        case sosEndpoint = "sos-endpoint"
    }
}
