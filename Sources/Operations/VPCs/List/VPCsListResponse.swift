import Foundation

extension VPCsOperations.List {
    struct Response: HttpResponse {
        let data: ListVPCsData

        func transform(client: Http.Client) -> [Exoscale.VPC] {
            data.vpcs.map { Exoscale.VPC(data: $0, client: client) }
        }
    }
}
