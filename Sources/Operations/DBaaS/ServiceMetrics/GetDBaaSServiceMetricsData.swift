import Foundation

/// Response for retrieving DBaaS service metrics.
struct GetDBaaSServiceMetricsData: Decodable, Sendable {
    let metrics: [String: Exoscale.JSONValue]
}
