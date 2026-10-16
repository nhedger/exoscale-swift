import Foundation

extension Exoscale.AIConsumptionQuota {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let quotaUOMPerMinute: Int?
    }
}

extension Exoscale.AIConsumptionQuota.Payload {
    enum CodingKeys: String, CodingKey {
        case quotaUOMPerMinute = "quota-uom-per-minute"
    }
}
