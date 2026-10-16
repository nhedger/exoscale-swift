import Foundation

extension InstanceTypesOperations.List {
    struct Response: HttpResponse {
        let data: ListInstanceTypesData

        func transform(client: Http.Client) -> [Exoscale.InstanceType] {
            data.instanceTypes.map { Exoscale.InstanceType(data: $0, client: client) }
        }
    }
}
