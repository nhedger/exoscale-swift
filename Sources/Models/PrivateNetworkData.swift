import Foundation

extension Exoscale.PrivateNetwork {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let labels: [String: String]?
        let name: String?
        let startIP: String?
        let leases: [Lease]?
        let id: String?
        let vni: Int?
        let netmask: String?
        let options: Options?
        let endIP: String?
    }
}

extension Exoscale.PrivateNetwork.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case labels
        case name
        case startIP = "start-ip"
        case leases
        case id
        case vni
        case netmask
        case options
        case endIP = "end-ip"
    }
}
