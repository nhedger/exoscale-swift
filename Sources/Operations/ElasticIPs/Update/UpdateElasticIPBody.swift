import Foundation

/// Request body for updating an Elastic IP.
struct UpdateElasticIPBody: Encodable, Sendable {
    let description: String?
    let healthcheck: Exoscale.ElasticIP.Healthcheck?
    let labels: [String: String]?
}
