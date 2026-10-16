import Foundation

extension ClustersOperations.GenerateKarpenterExoscaleNodeclass {
    struct Response: HttpResponse {
        let data: KarpenterNodeclassData

        func transform(client _: Http.Client) -> String {
            data.exoscaleNodeclass
        }
    }
}
