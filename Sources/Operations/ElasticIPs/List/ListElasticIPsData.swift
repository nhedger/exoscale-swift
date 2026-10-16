import Foundation

/// Response for listing Elastic IPs.
struct ListElasticIPsData: Decodable, Sendable {
    let elasticIPs: [Exoscale.ElasticIP.Payload]

    enum CodingKeys: String, CodingKey {
        case elasticIPs = "elastic-ips"
    }
}
