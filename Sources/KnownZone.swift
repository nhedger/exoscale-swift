import Foundation

public extension Exoscale {
    /// Exoscale availability zones known by the SDK.
    ///
    /// API responses and client configuration use `ZoneName`, which also covers newer zones.
    enum KnownZone: String, Hashable, CaseIterable, Codable, Sendable {
        case atVie1 = "at-vie-1"
        case atVie2 = "at-vie-2"
        case bgSof1 = "bg-sof-1"
        case chDk2 = "ch-dk-2"
        case chGva2 = "ch-gva-2"
        case deFra1 = "de-fra-1"
        case deMuc1 = "de-muc-1"
        case hrZag1 = "hr-zag-1"

        /// The zone's identifier.
        public var name: ZoneName {
            ZoneName(self)
        }

        /// The Exoscale API base URL for this zone.
        public var apiEndpoint: URL {
            name.endpoints!.api
        }

        /// The Exoscale SOS object storage base URL for this zone.
        public var sosEndpoint: URL {
            name.endpoints!.sos
        }
    }
}
