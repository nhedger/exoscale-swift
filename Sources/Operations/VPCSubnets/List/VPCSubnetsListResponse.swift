import Foundation

extension VPCSubnetsOperations.List {
    struct Response: HttpResponse {
        let data: ListVPCSubnetsData

        func transform(client: Http.Client) -> [Exoscale.VPCSubnet] {
            data.subnets.map { Exoscale.VPCSubnet(data: $0, client: client) }
        }
    }
}
