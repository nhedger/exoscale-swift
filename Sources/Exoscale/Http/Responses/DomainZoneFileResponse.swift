/// Response for retrieving a DNS domain zone file.
struct DomainZoneFileResponse: Codable, Sendable {
    let zoneFile: String

    enum CodingKeys: String, CodingKey {
        case zoneFile = "zone-file"
    }
}
