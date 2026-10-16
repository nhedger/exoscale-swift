import Foundation

extension Exoscale.VPCSubnet {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let description: String?
        let createdAt: Date?
        let labels: [String: String]?
        let addressFamily: String?
        let addressSpace: String?
        let ipv4Block: String?
        let instances: [Instance]?
    }
}

extension Exoscale.VPCSubnet.Payload {
    enum CodingKeys: String, CodingKey {
        case id, name, description, labels, instances
        case createdAt = "created-at"
        case addressFamily = "addressfamily"
        case addressSpace = "address-space"
        case ipv4Block = "ipv4-block"
    }
}
