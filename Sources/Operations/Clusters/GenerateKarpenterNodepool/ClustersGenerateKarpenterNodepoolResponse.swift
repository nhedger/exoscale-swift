import Foundation

extension ClustersOperations.GenerateKarpenterNodepool {
    struct Response: HttpResponse {
        let data: KarpenterNodepoolData

        func transform(client _: Http.Client) -> String {
            data.nodepool
        }
    }
}
