import Foundation

extension InstancePoolsOperations.List {
    struct Response: HttpResponse {
        let data: ListInstancePoolsData

        func transform(client: Http.Client) -> [Exoscale.InstancePool] {
            data.instancePools.map { Exoscale.InstancePool(data: $0, client: client) }
        }
    }
}
