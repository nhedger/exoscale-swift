import Foundation

extension ClustersOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.SKSCluster.Payload

        func transform(client: Http.Client) -> Exoscale.SKSCluster {
            Exoscale.SKSCluster(data: data, client: client)
        }
    }
}
