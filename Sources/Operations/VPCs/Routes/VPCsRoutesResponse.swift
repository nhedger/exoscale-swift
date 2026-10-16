import Foundation

extension VPCsOperations.Routes {
    struct Response: HttpResponse {
        let data: ListVPCRoutesData

        func transform(client: Http.Client) -> [Exoscale.VPCRoute] {
            data.routes.map { Exoscale.VPCRoute(data: $0, client: client) }
        }
    }
}
