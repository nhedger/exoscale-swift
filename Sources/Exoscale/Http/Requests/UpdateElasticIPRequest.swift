/// Request body for updating an Elastic IP.
struct UpdateElasticIPRequest: Codable, Sendable {
    let description: String?
    let healthcheck: Exoscale.ElasticIP.Healthcheck?
    let labels: [String: String]?
}
