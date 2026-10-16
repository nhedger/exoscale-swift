import Foundation

extension ClustersOperations.ListVersions {
    struct Response: HttpResponse {
        let data: ListSKSClusterVersionsData

        func transform(client _: Http.Client) -> [String] {
            data.versions
        }
    }
}
