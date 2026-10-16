import Foundation

extension Exoscale.ElasticIP {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let ip: String?
        let addressFamily: AddressFamily?
        let cidr: String?
        let description: String?
        let healthcheck: Healthcheck?
        let labels: [String: String]?
    }
}

extension Exoscale.ElasticIP.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case ip
        case addressFamily = "addressfamily"
        case cidr
        case description
        case healthcheck
        case labels
    }
}
