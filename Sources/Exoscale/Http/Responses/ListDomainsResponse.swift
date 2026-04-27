/// Response for listing DNS domains.
public struct ListDomainsResponse: Codable, Sendable {
    public let domains: [Exoscale.Domain]

    enum CodingKeys: String, CodingKey {
        case domains = "dns-domains"
    }
}
