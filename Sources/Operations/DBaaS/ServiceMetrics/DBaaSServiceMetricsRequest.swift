import Foundation

extension DBaaSOperations.ServiceMetrics {
    struct Request: HttpRequest {
        let serviceName: String
        let period: Exoscale.DBaaS.MetricsPeriod?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(GetDBaaSServiceMetricsBody(period: period))

            return Http.Request(
                method: .post,
                path: "/dbaas-service-metrics/\(serviceName)",
                body: body
            )
        }
    }
}
