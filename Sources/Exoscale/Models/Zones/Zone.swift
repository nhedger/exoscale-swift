import Foundation

public extension Exoscale {
    /// Exoscale zone returned by the API.
    struct Zone: Codable, Sendable {
        public let name: Exoscale.KnownZone
        public let apiEndpoint: URL
        public let sosEndpoint: URL

        enum CodingKeys: String, CodingKey {
            case name
            case apiEndpoint = "api-endpoint"
            case sosEndpoint = "sos-endpoint"
        }
    }
}
