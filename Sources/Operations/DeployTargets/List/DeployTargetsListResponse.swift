import Foundation

extension DeployTargetsOperations.List {
    struct Response: HttpResponse {
        let data: ListDeployTargetsData

        func transform(client: Http.Client) -> [Exoscale.DeployTarget] {
            data.deployTargets.map { Exoscale.DeployTarget(data: $0, client: client) }
        }
    }
}
