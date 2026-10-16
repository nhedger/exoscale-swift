import Foundation

extension DeploymentsOperations.Logs {
    struct Response: HttpResponse {
        let data: GetDeploymentLogsData

        func transform(client: Http.Client) -> [Exoscale.AIDeploymentLogEntry] {
            data.logs.map { Exoscale.AIDeploymentLogEntry(data: $0, client: client) }
        }
    }
}
