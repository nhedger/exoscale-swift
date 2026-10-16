import Foundation

extension InstancesOperations.List {
    struct Response: HttpResponse {
        let data: ListInstancesData

        func transform(client: Http.Client) -> [Exoscale.InstanceSummary] {
            data.instances.map { Exoscale.InstanceSummary(data: $0, client: client) }
        }
    }
}
