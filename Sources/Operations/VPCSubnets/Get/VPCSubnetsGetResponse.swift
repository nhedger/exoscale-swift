import Foundation

extension VPCSubnetsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.VPCSubnet.Payload

        func transform(client: Http.Client) -> Exoscale.VPCSubnet {
            Exoscale.VPCSubnet(data: data, client: client)
        }
    }
}
