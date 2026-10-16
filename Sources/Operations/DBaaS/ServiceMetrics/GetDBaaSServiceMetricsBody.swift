import Foundation

/// Request body for querying DBaaS service metrics.
struct GetDBaaSServiceMetricsBody: Encodable, Sendable {
    let period: Exoscale.DBaaS.MetricsPeriod?
}
