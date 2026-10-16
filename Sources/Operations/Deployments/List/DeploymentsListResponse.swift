import Foundation

extension DeploymentsOperations.List {
    struct Response: HttpResponse {
        let data: ListDeploymentsData

        func transform(client: Http.Client) -> [Exoscale.AIDeployment] {
            data.deployments.map { Exoscale.AIDeployment(data: $0, client: client) }
        }
    }
}
