import Foundation

extension VPCsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.VPC.Payload

        func transform(client: Http.Client) -> Exoscale.VPC {
            Exoscale.VPC(data: data, client: client)
        }
    }
}
