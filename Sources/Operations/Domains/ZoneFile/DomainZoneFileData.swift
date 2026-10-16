import Foundation

/// Response for retrieving a DNS domain zone file.
struct DomainZoneFileData: Decodable, Sendable {
    let zoneFile: String

    enum CodingKeys: String, CodingKey {
        case zoneFile = "zone-file"
    }
}
