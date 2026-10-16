import Foundation

extension VPCsOperations.Update {
    struct Response: HttpResponse {
        let data: Exoscale.VPC.Payload

        func transform(client: Http.Client) -> Exoscale.VPC {
            Exoscale.VPC(data: data, client: client)
        }
    }
}
