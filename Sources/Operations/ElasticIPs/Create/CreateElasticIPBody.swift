import Foundation

/// Request body for creating an Elastic IP.
struct CreateElasticIPBody: Encodable, Sendable {
    let addressFamily: Exoscale.ElasticIP.AddressFamily?
    let description: String?
    let healthcheck: Exoscale.ElasticIP.Healthcheck?
    let labels: [String: String]?

    enum CodingKeys: String, CodingKey {
        case addressFamily = "addressfamily"
        case description
        case healthcheck
        case labels
    }
}
