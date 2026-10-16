import Foundation

extension DeployTargetsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DeployTarget.Payload

        func transform(client: Http.Client) -> Exoscale.DeployTarget {
            Exoscale.DeployTarget(data: data, client: client)
        }
    }
}
