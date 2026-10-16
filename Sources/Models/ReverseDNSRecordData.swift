import Foundation

extension Exoscale.ReverseDNSRecord {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let domainName: String?
    }
}

extension Exoscale.ReverseDNSRecord.Payload {
    enum CodingKeys: String, CodingKey {
        case domainName = "domain-name"
    }
}
