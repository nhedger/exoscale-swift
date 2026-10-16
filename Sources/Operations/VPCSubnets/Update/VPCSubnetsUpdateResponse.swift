import Foundation

extension VPCSubnetsOperations.Update {
    struct Response: HttpResponse {
        let data: Exoscale.VPCSubnet.Payload

        func transform(client: Http.Client) -> Exoscale.VPCSubnet {
            Exoscale.VPCSubnet(data: data, client: client)
        }
    }
}
