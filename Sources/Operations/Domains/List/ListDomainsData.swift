import Foundation

/// Response for listing DNS domains.
struct ListDomainsData: Decodable, Sendable {
    let domains: [Exoscale.Domain.Payload]

    enum CodingKeys: String, CodingKey {
        case domains = "dns-domains"
    }
}
