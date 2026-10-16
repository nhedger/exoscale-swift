import Foundation

extension ClustersOperations.List {
    struct Response: HttpResponse {
        let data: ListSKSClustersData

        func transform(client: Http.Client) -> [Exoscale.SKSCluster] {
            data.clusters.map { Exoscale.SKSCluster(data: $0, client: client) }
        }
    }
}
