import Foundation

extension DBaaSExternalEndpointsOperations.List {
    struct Response: HttpResponse {
        let data: ListDBaaSExternalEndpointsData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ExternalEndpoint] {
            data.dbaasEndpoints.map { Exoscale.DBaaS.ExternalEndpoint(data: $0, client: client) }
        }
    }
}
