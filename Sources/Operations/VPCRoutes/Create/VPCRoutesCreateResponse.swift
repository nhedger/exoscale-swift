import Foundation

extension VPCRoutesOperations.Create {
    struct Response: HttpResponse {
        let data: Exoscale.VPCRoute.Payload

        func transform(client: Http.Client) -> Exoscale.VPCRoute {
            Exoscale.VPCRoute(data: data, client: client)
        }
    }
}
