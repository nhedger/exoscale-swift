import Foundation

extension ClustersOperations.Inspection {
    struct Response: HttpResponse {
        let data: [String: Exoscale.JSONValue]

        func transform(client _: Http.Client) -> [String: Exoscale.JSONValue] {
            data
        }
    }
}
