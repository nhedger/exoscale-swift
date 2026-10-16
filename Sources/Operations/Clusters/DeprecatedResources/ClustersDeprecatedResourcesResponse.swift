import Foundation

extension ClustersOperations.DeprecatedResources {
    struct Response: HttpResponse {
        let data: [Exoscale.SKSClusterDeprecatedResource.Payload]

        func transform(client: Http.Client) -> [Exoscale.SKSClusterDeprecatedResource] {
            data.map { Exoscale.SKSClusterDeprecatedResource(data: $0, client: client) }
        }
    }
}
