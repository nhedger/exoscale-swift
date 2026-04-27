import Foundation

public extension Exoscale {
    /// Exoscale availability zones known by the SDK.
    enum KnownZone: String, Hashable, CaseIterable, Codable, Sendable {
        case atVie1 = "at-vie-1"
        case atVie2 = "at-vie-2"
        case bgSof1 = "bg-sof-1"
        case chDk2 = "ch-dk-2"
        case chGva2 = "ch-gva-2"
        case deFra1 = "de-fra-1"
        case deMuc1 = "de-muc-1"
        case hrZag1 = "hr-zag-1"

        /// The Exoscale API base URL for this zone.
        public var apiEndpoint: URL {
            URL(string: "https://api-\(rawValue).exoscale.com/v2")!
        }

        /// The Exoscale SOS object storage base URL for this zone.
        public var sosEndpoint: URL {
            URL(string: "https://sos-\(rawValue).exo.io")!
        }
    }
}
