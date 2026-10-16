import Foundation

extension DeploymentsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.AIDeployment.Payload

        func transform(client: Http.Client) -> Exoscale.AIDeployment {
            Exoscale.AIDeployment(data: data, client: client)
        }
    }
}
