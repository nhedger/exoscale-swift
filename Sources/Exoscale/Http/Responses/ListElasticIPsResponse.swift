/// Response for listing Elastic IPs.
public struct ListElasticIPsResponse: Codable, Sendable {
    public let elasticIPs: [Exoscale.ElasticIP]

    enum CodingKeys: String, CodingKey {
        case elasticIPs = "elastic-ips"
    }
}
