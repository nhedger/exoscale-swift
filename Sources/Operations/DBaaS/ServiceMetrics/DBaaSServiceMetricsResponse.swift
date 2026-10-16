import Foundation

extension DBaaSOperations.ServiceMetrics {
    struct Response: HttpResponse {
        let data: GetDBaaSServiceMetricsData

        func transform(client _: Http.Client) -> [String: Exoscale.JSONValue] {
            data.metrics
        }
    }
}
