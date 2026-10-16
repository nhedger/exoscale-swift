import Foundation

extension Exoscale.SOSBucketUsage {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let createdAt: Date?
        let zoneName: Exoscale.ZoneName?
        let size: Int?
    }
}

extension Exoscale.SOSBucketUsage.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case createdAt = "created-at"
        case zoneName = "zone-name"
        case size
    }
}
